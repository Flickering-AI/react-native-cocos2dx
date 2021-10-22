package com.xuanping.cocos2dx

import android.graphics.Color
import android.graphics.PixelFormat
import android.media.AudioManager
import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.view.Window
import android.view.WindowManager
import android.widget.FrameLayout
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReadableArray
import com.facebook.react.uimanager.SimpleViewManager
import com.facebook.react.uimanager.ThemedReactContext
import org.cocos2dx.lib.*
import org.cocos2dx.lib.Cocos2dxActivity.Cocos2dxEGLConfigChooser
import org.cocos2dx.lib.Cocos2dxGLSurfaceView
import com.facebook.react.uimanager.annotations.ReactProp







class Cocos2dxGLViewManager(reactContext: ReactApplicationContext): SimpleViewManager<Cocos2dxGLSurfaceView>() {

  init {
    reactContext.currentActivity?.runOnUiThread {
      System.loadLibrary("cocos2djs")
      Cocos2dxHelper.init(reactContext.currentActivity)
      CanvasRenderingContext2DImpl.init(reactContext.currentActivity)
      val glSurfaceView = Cocos2dxGLSurfaceView(reactContext.currentActivity)
      glSurfaceView.setEGLConfigChooser(5, 6, 5, 0, 16, 8)
      glSurfaceView.preserveEGLContextOnPause = true
      // Should set to transparent, or it will hide EditText
      // https://stackoverflow.com/questions/2978290/androids-edittext-is-hidden-when-the-virtual-keyboard-is-shown-and-a-surfacevie
      glSurfaceView.setBackgroundColor(Color.TRANSPARENT)
      val renderer = Cocos2dxRenderer()
      glSurfaceView.setCocos2dxRenderer(renderer)
    }
  }

  override fun getName(): String = "Cocos2dxGLView"

  override fun createViewInstance(reactContext: ThemedReactContext): Cocos2dxGLSurfaceView = Cocos2dxGLSurfaceView.getInstance()

  @ReactProp(name = "alpha")
  fun alpha(view: Cocos2dxGLSurfaceView, alpha: Float) {
    view.alpha = alpha
  }
}


//class Cocos2dxGLViewManager(reactContext: ReactApplicationContext) : SimpleViewManager<View>() {
//
//  override fun getName() = "Cocos2dxGLView"
//
//  override fun createViewInstance(reactContext: ThemedReactContext): View {
//    return View(reactContext)
//  }
//
//  @ReactProp(name = "color")
//  fun setColor(view: View, color: String) {
//    view.setBackgroundColor(Color.parseColor(color))
//  }
//
//  @ReactProp(name = "alpha")
//  fun setAlpha(view: View, alpha: Float) {
//    view.alpha = alpha
//  }
//}
