package com.xuanping.cocos2dx

import com.facebook.react.ReactPackage
import com.facebook.react.bridge.*
import com.facebook.react.uimanager.ViewManager


class Cocos2dxPackage : ReactPackage, JSIModulePackage {

  override fun createNativeModules(reactContext: ReactApplicationContext): List<NativeModule> = listOf(Cocos2dxGLViewModule(), Cocos2dxModule())

  override fun createViewManagers(reactContext: ReactApplicationContext): List<ViewManager<*, *>> = listOf(Cocos2dxGLViewManager(reactContext))

  override fun getJSIModules(reactApplicationContext: ReactApplicationContext?, jsContext: JavaScriptContextHolder?): MutableList<JSIModuleSpec<JSIModule>> {
    Cocos2dxModule.install(jsContext)
    return arrayListOf()
  }

}
