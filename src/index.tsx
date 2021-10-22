import React from 'react';
import {
  requireNativeComponent,
  UIManager,
  Platform,
  NativeModules,
  View,
  StyleSheet,
  ViewStyle,
  StyleProp,
} from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-cocos2dx' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

type Cocos2dGLViewNativeProps = {
  alpha?: number;
  style?: StyleProp<ViewStyle>;
};

const viewManagerName = 'Cocos2dxGLView';

export const Cocos2dxGLViewManager =
  UIManager.getViewManagerConfig(viewManagerName) != null
    ? requireNativeComponent<Cocos2dGLViewNativeProps>(viewManagerName)
    : () => {
        throw new Error(LINKING_ERROR);
      };

export const Cocos2dxGLViewModule: {
  onResume: () => Promise<boolean>;
  onPause: () => Promise<boolean>;
} =
  NativeModules.Cocos2dxGLViewModule ||
  new Proxy(
    {},
    {
      get() {
        throw new Error(LINKING_ERROR);
      },
    }
  );
//
// export const Cocos2dxModule: {
//   evalString: () => Promise<boolean>;
// } =
//   NativeModules.Cocos2dxModule ||
//   new Proxy(
//     {},
//     {
//       get() {
//         throw new Error(LINKING_ERROR);
//       },
//     }
//   );

type Cocos2dGLViewProps = Cocos2dGLViewNativeProps & {
  onMessage?: (data?: string | number | {} | []) => void;
};

export const Cocos2dxGLView = React.memo((props: Cocos2dGLViewProps) => {
  const { alpha = 1, onMessage = () => {}, style } = props;
  React.useEffect(() => {
    // @ts-ignore
    global.postMessageToReactNative = onMessage;
  }, [onMessage]);
  return (
    <View style={[styles.container, style]}>
      <Cocos2dxGLViewManager style={styles.container} alpha={alpha} />
    </View>
  );
});

// @ts-ignore
export const evalString = global.evalString as (params: {
  javascriptString: string;
}) => void;

const styles = StyleSheet.create({
  container: { flex: 1 },
});
