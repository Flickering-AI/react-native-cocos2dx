LOCAL_PATH := $(call my-dir)

REACT_NDK_EXPORT_DIR := $(PROJECT_BUILD_DIR)/react-native-$(REACT_NATIVE_TARGET_VERSION).aar/jni
REACT_COMMON_DIR := $(NODE_MODULES_DIR)/react-native/ReactCommon
#$(info "REACT_NDK_EXPORT_DIR:$(REACT_COMMON_DIR)/jsi")


#include $(CLEAR_VARS)
#LOCAL_CPP_FEATURES := rtti exceptions
#LOCAL_MODULE := folly_json
#LOCAL_SRC_FILES := $(REACT_NDK_EXPORT_DIR)/$(TARGET_ARCH_ABI)/libfolly_json.so
#include $(PREBUILT_SHARED_LIBRARY)
#
#include $(CLEAR_VARS)
#LOCAL_CPP_FEATURES := rtti exceptions
#LOCAL_MODULE := glog
#LOCAL_SRC_FILES := $(REACT_NDK_EXPORT_DIR)/$(TARGET_ARCH_ABI)/libglog.so
#include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_CPP_FEATURES := rtti exceptions
LOCAL_MODULE := jsi
LOCAL_SRC_FILES := $(REACT_NDK_EXPORT_DIR)/$(TARGET_ARCH_ABI)/libjsi.so
LOCAL_EXPORT_C_INCLUDES := $(REACT_COMMON_DIR)/jsi $(REACT_COMMON_DIR)/jsi/jsi
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := reactnativecocos2dx
LOCAL_SRC_FILES := ../src/main/cpp/cpp-adapter.cpp
LOCAL_C_INCLUDES := "${NODE_MODULES_DIR}/react-native/React" \
										"${NODE_MODULES_DIR}/react-native/React/Base" \
										"${NODE_MODULES_DIR}/react-native/ReactAndroid/src/main/jni/third-party" \
										"${NODE_MODULES_DIR}/react-native/ReactAndroid/src/main/java/com/facebook/react/turbomodule/core/jni" \
										"${NODE_MODULES_DIR}/react-native/ReactCommon" \
										"${NODE_MODULES_DIR}/react-native/ReactCommon/callinvoker" \
										"${NODE_MODULES_DIR}/react-native/ReactCommon/jsi" \

LOCAL_CFLAGS := -fexceptions -frtti
LOCAL_SHARED_LIBRARIES := libjsi libcocos2djs
include $(BUILD_SHARED_LIBRARY)

#include ${NODE_MODULES_DIR}/react-native/ReactCommon/jsi/Android.mk
include $(COCOS_BUILD_PATH)/jsb-default/frameworks/runtime-src/proj.android-studio/jni/CocosAndroid.mk
