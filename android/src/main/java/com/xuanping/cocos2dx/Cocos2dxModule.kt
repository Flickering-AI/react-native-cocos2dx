package com.xuanping.cocos2dx

import android.util.Log
import com.facebook.react.bridge.JavaScriptContextHolder
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.module.annotations.ReactModule
import org.cocos2dx.lib.Cocos2dxJavascriptJavaBridge


@ReactModule(name = "Cocos2dxModule", isCxxModule = true)
class Cocos2dxModule: ReactContextBaseJavaModule() {

  companion object {

    init {
      try {
        System.loadLibrary("reactnativecocos2dx")
      } catch (ignored: Exception) {
      }
    }

    fun install(reactContext: JavaScriptContextHolder?) {
      if (reactContext?.get() != 0L) {
        this.nativeInstall(
          reactContext!!.get()
        )
      } else {
        Log.e("SimpleJsiModule", "JSI Runtime is not available in debug mode")
      }
    }

    private external fun nativeInstall(jsi: Long)
  }

  override fun getName(): String = "Cocos2dx"
}
