import {
  requireNativeComponent,
  UIManager,
  Platform,
  ViewStyle,
} from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-cocos2d-glview' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

type Cocos2dGlviewProps = {
  color: string;
  style: ViewStyle;
};

const ComponentName = 'Cocos2dGlviewView';

export const Cocos2dGlviewView =
  UIManager.getViewManagerConfig(ComponentName) != null
    ? requireNativeComponent<Cocos2dGlviewProps>(ComponentName)
    : () => {
        throw new Error(LINKING_ERROR);
      };
