#import "React/RCTViewManager.h"
#import "React/RCTBridgeModule.h"
#import "CocosWrapper.h"

#include "cocos2d.h"
#include "platform/CCApplication.h"
#include "platform/ios/CCEAGLView-ios.h"
#include "AppDelegate.h"
#include "cocos/scripting/js-bindings/jswrapper/SeApi.h"
#include "cocos/scripting/js-bindings/jswrapper/v8/HelperMacros.h"
#include "platform/CCApplication.h"
#include "base/CCScheduler.h"

#import <React/RCTBridge+Private.h>
#import <React/RCTUtils.h>
#import <jsi/jsi.h>

using namespace facebook::jsi;
using namespace cocos2d;
facebook::jsi::Runtime * globalJsiRuntime = nullptr;

@implementation CocosWrapper
+(UIView *) glview {
  cocos2d::Application* app = cocos2d::Application::getInstance();
  UIView* glview = nullptr;
  if (!app) {
    float scale = [[UIScreen mainScreen] scale];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    app = new AppDelegate(bounds.size.width*scale, bounds.size.height*scale);
    app->setMultitouch(true);
    glview = (__bridge CCEAGLView *)app->getView();
    app->start();
  } else {
    glview = (__bridge CCEAGLView *)cocos2d::Application::getInstance()->getView();
  }
  return glview;
}
@end

@interface RCT_EXTERN_MODULE(Cocos2dxGLView, RCTViewManager)
RCT_EXPORT_VIEW_PROPERTY(color, NSString)
RCT_EXPORT_VIEW_PROPERTY(width, NSString)
@end

@interface RCT_EXTERN_MODULE(Cocos2dxGLViewModule, NSObject<RCTBridgeModule>)
RCT_EXTERN_METHOD(
  onResume: (RCTPromiseResolveBlock)resolve
  rejecter: (RCTPromiseRejectBlock)reject
)

RCT_EXTERN_METHOD(
  onPause: (RCTPromiseResolveBlock)resolve
  rejecter: (RCTPromiseRejectBlock)reject
)
@end


@interface Cocos2dxModule : NSObject <RCTBridgeModule>
@property (nonatomic, assign) BOOL setBridgeOnMainQueue;
@end

@implementation Cocos2dxModule
@synthesize bridge = _bridge;
@synthesize methodQueue = _methodQueue;

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup {
    
    return YES;
}

- (void)setBridge:(RCTBridge *)bridge {
    _bridge = bridge;
    _setBridgeOnMainQueue = RCTIsMainQueue();
    [self installLibrary];
}

- (void)installLibrary {
    
    RCTCxxBridge *cxxBridge = (RCTCxxBridge *)self.bridge;
    
    if (!cxxBridge.runtime) {
        
        /**
         * This is a workaround to install library
         * as soon as runtime becomes available and is
         * not recommended. If you see random crashes in iOS
         * global.xxx not found etc. use this.
         */
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.001 * NSEC_PER_SEC),
                       dispatch_get_main_queue(), ^{
            /**
             When refreshing the app while debugging, the setBridge
             method is called too soon. The runtime is not ready yet
             quite often. We need to install library as soon as runtime
             becomes available.
             */
            [self installLibrary];
            
        });
        return;
    }
    
    install(*(facebook::jsi::Runtime *)cxxBridge.runtime);
}
std::string getPropertyAsStringOrEmptyFromObject(facebook::jsi::Object& object, const std::string& propertyName, facebook::jsi::Runtime& runtime) {
    facebook::jsi::Value value = object.getProperty(runtime, propertyName.c_str());
    return value.isString() ? value.asString(runtime).utf8(runtime) : "";
}

bool evalString(se::State& s)
{
    const auto& args = s.args();
//  args[0].toString()
  std::string text = args[0].toString();
  std::shared_ptr<StringBuffer> buffer = std::make_shared<StringBuffer>(StringBuffer(text));
  const std::string sourceURL = "";
  globalJsiRuntime->evaluateJavaScript(buffer, sourceURL);
//    globalJsiRuntime->global().getPropertyAsFunction(*globalJsiRuntime, "postMessageToReactNative").call(*globalJsiRuntime, args[0].toString());
    return true;
}
SE_BIND_FUNC(evalString)
void install(Runtime &jsiRuntime) {
  globalJsiRuntime = &jsiRuntime;
  if (globalJsiRuntime) {
    facebook::jsi::Runtime &jsiRuntime = *globalJsiRuntime;
    const char* functionName = "evalString";
    auto evalString = Function::createFromHostFunction(
            jsiRuntime,
            PropNameID::forAscii(jsiRuntime, functionName),
            0,
            [](Runtime &runtime,const facebook::jsi::Value &thisValue,const facebook::jsi::Value *arguments,size_t count) -> facebook::jsi::Value {
                if (count != 1) {
                    throw facebook::jsi::JSError(runtime, "evalString(..) expects one argument (object)!");
                }
                facebook::jsi::Object config = arguments[0].asObject(runtime);

                std::string javascriptString = getPropertyAsStringOrEmptyFromObject(config, "javascriptString", runtime);
                Application::getInstance()->getScheduler()->performFunctionInCocosThread([javascriptString]{
                    se::ScriptEngine::getInstance()->evalString(javascriptString.c_str());
                });
                return facebook::jsi::Value(runtime, facebook::jsi::Value(1));
            });
    jsiRuntime.global().setProperty(jsiRuntime, functionName, std::move(evalString));
    se::ScriptEngine::getInstance()->addRegisterCallback([](se::Object* obj){
      const char *envName = "ReactNative";
        // Get the ns
        se::Value nsVal;
        if (!obj->getProperty(envName, &nsVal))
        {
            se::HandleObject jsobj(se::Object::createPlainObject());
            jsobj->defineFunction("evalString", _SE(evalString));
            nsVal.setObject(jsobj);
            obj->setProperty(envName, nsVal);
        }
        return true;
    });
  }
}

@end
