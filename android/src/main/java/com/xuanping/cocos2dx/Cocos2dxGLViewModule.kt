package com.xuanping.cocos2dx

import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.module.annotations.ReactModule
import org.cocos2dx.lib.Cocos2dxGLSurfaceView

@ReactModule(name = "Cocos2dxGLViewModule")
class Cocos2dxGLViewModule : ReactContextBaseJavaModule() {

  override fun getName(): String = "Cocos2dxGLViewModule"

  @ReactMethod
  fun onResume(promise: Promise) {
    Cocos2dxGLSurfaceView.getInstance().onResume()
    promise.resolve(true)
  }

  @ReactMethod
  fun onPause(promise: Promise) {
    Cocos2dxGLSurfaceView.getInstance().onPause()
    promise.resolve(true)
  }
}
