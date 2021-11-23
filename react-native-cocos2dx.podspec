require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))
Pod::Spec.new do |s|
  s.name         = "react-native-cocos2dx"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => "10.0" }
  s.source       = { :git => "https://github.com/lxp-git/react-native-cocos2dx.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,mm,swift,c,cpp,hpp}"
  
  s.user_target_xcconfig    = {
    'HEADER_SEARCH_PATHS' => ('"../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x" "../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/cocos" "../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/cocos/platform" "../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/cocos/platform/ios" "../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/cocos/scripting/js-bindings/auto" "../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/cocos/scripting/js-bindings/manual" "../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/external/ios/include" "../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/external/ios/include/v8" "../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/cocos/editor-support" "../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/external/sources" "../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/external/ios/include/spidermonkey"'),
    'LIBRARY_SEARCH_PATHS' => ('"../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/external/ios/libs"')
  }

  s.dependency "React-Core"
  s.frameworks = 'SystemConfiguration', 'CoreMotion', 'AVKit', 'OpenAL', 'libsqlite3'
  s.libraries = 'cocos2d iOS'
  s.vendored_libraries = '../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/external/ios/libs/libcrypto.a', '../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/external/ios/libs/libfreetype.a', '../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/external/ios/libs/libjpeg.a', '../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/external/ios/libs/libjs_static.a', '../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/external/ios/libs/libmozglue.a', '../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/external/ios/libs/libpng.a', '../../InitCocos246/build/jsb-default/frameworks/cocos2d-x/external/ios/libs/libssl.a', '../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/external/ios/libs/libtiff.a', '../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/external/ios/libs/libuv_a.a', '../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/external/ios/libs/libv8_monolith.a', '../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/external/ios/libs/libwebp.a', '../../cocos/InitCocos246/build/jsb-default/frameworks/cocos2d-x/external/ios/libs/libwebsockets.a'
end
