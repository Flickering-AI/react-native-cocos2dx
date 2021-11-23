# react-native-cocos2dx

基于ReactNative JSI实现，暂时还无法Auto Linking. 需要一些手动配置，见：使用方法。

## Installation

```sh
yarn add react-native-cocos2dx@https://github.com/lxp-git/react-native-cocos2dx.git
```

## 使用方法

### iOS

请按照Cocos工程的Hello World设置好工程的Cocos2d依赖。

### Android

已经帮你实现了Cocos2d依赖，但是需要手动填入Cocos工程build出来的build目录， 在工程根目录的 `.env` 文件里面设置 `COCOS_BUILD_PATH`。

### js
```js
import { Cocos2dGlviewView } from 'react-native-cocos2dx';

// ...

<View style={{ flex: 1 }}>
  <Cocos2dxGLView />
</View>;
```

具体见 ./example

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
