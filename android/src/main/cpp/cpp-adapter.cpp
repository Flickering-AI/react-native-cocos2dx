#include <jni.h>
#include <jsi/jsi.h>
#include <android/looper.h>
#include <unistd.h>

#include "cocos/scripting/js-bindings/jswrapper/SeApi.h"
#include "cocos/scripting/js-bindings/jswrapper/v8/HelperMacros.h"
#include "platform/CCApplication.h"
#include "base/CCScheduler.h"

using namespace facebook::jsi;
using namespace std;
using namespace cocos2d;

facebook::jsi::Runtime * globalJsiRuntime = nullptr;


std::string getPropertyAsStringOrEmptyFromObject(facebook::jsi::Object& object, const std::string& propertyName, facebook::jsi::Runtime& runtime) {
    facebook::jsi::Value value = object.getProperty(runtime, propertyName.c_str());
    return value.isString() ? value.asString(runtime).utf8(runtime) : "";
}

bool postMessageToReactNative(se::State& s)
{
    const auto& args = s.args();
    globalJsiRuntime->global().getPropertyAsFunction(*globalJsiRuntime, "postMessageToReactNative").call(*globalJsiRuntime, args[0].toString());
    return true;
}
SE_BIND_FUNC(postMessageToReactNative)

extern "C"
JNIEXPORT void JNICALL
Java_com_xuanping_cocos2dx_Cocos2dxModule_00024Companion_nativeInstall(JNIEnv *env, jobject thiz,
                                                                       jlong jsiPtr) {
    globalJsiRuntime = reinterpret_cast<facebook::jsi::Runtime*>(jsiPtr);
    if (globalJsiRuntime) {
        facebook::jsi::Runtime &jsiRuntime = *globalJsiRuntime;
        auto evalString = Function::createFromHostFunction(
                jsiRuntime,
                PropNameID::forAscii(jsiRuntime,"evalString"),
                0,
                [](Runtime &runtime,const Value &thisValue,const Value *arguments,size_t count) -> Value {
                    if (count != 1) {
                        throw facebook::jsi::JSError(runtime, "evalString(..) expects one argument (object)!");
                    }
                    facebook::jsi::Object config = arguments[0].asObject(runtime);

                    std::string javascriptString = getPropertyAsStringOrEmptyFromObject(config, "javascriptString", runtime);
                    Application::getInstance()->getScheduler()->performFunctionInCocosThread([javascriptString]{
                        se::ScriptEngine::getInstance()->evalString(javascriptString.c_str());
                    });
                    return Value(runtime, Value(1));
                });
        jsiRuntime.global().setProperty(jsiRuntime, "evalString", move(evalString));
        se::ScriptEngine::getInstance()->addRegisterCallback([](se::Object* obj){
            // Get the ns
            se::Value nsVal;
            if (!obj->getProperty("cc", &nsVal))
            {
                se::HandleObject jsobj(se::Object::createPlainObject());
                jsobj->defineFunction("postMessageToReactNative", _SE(postMessageToReactNative));
                nsVal.setObject(jsobj);
                obj->setProperty("cc", nsVal);
            }
            return true;
        });
    }
}
