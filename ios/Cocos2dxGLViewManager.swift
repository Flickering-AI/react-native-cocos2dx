import CoreFoundation

@objc(Cocos2dxGLView)
class Cocos2dxGLView: RCTViewManager {
  
  override static func moduleName() -> String! {
    return "Cocos2dxGLView";
  }

  override class func requiresMainQueueSetup() -> Bool {
    return false
  }
  
//  @objc var width: Double = 0.0 {
//    didSet {
//      self.bridge.
//      print(width)
//    }
//  }
  
  override func view() -> (UIView) {
    let glView = CocosWrapper.glview()
    return glView!
  }
}


@objc(Cocos2dxGLViewModule)
class Cocos2dxGLViewModule: NSObject, RCTBridgeModule {
  
  @objc
  func constantsToExport() -> [AnyHashable : Any]! {
    return ["initialCount": 0]
  }
  
  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  static func moduleName() -> String! {
    return "Cocos2dxGLViewModule"
  }
  
  @objc
  func onResume(_ resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) -> Void {
//    if (count == 0) {
//      let error = NSError(domain: "", code: 200, userInfo: nil)
//      reject("E_COUNT", "count cannot be negative", error)
//    } else {
//      count -= 1
//      resolve("count was decremented")
//    }
    resolve(true)
  }
  
  @objc
  func onPause(_ resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) -> Void {
//    if (count == 0) {
//      let error = NSError(domain: "", code: 200, userInfo: nil)
//      reject("E_COUNT", "count cannot be negative", error)
//    } else {
//      count -= 1
//      resolve("count was decremented")
//    }
    resolve(true)
  }

  
}
