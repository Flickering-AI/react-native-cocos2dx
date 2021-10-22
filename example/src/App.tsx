import * as React from 'react';

import { StatusBar, StyleSheet, View, Text, Button } from 'react-native';
import {
  Cocos2dxGLView,
  Cocos2dxGLViewModule,
  evalString,
} from 'react-native-cocos2dx';

export default function App() {
  const [isCocosVisible, setIsCocosVisible] = React.useState(true);
  const [log, setLog] = React.useState('');
  React.useEffect(() => {
    Cocos2dxGLViewModule.onResume();
  }, []);
  return (
    <View style={styles.container}>
      <StatusBar translucent backgroundColor="transparent" />
      <View style={styles.container}>
        {isCocosVisible && (
          <Cocos2dxGLView
            onMessage={(data) => {
              setLog(data?.toString()!);
            }}
          />
        )}
      </View>
      <View style={styles.container}>
        <View style={{ margin: 16 }}>
          <Button
            onPress={() => {
              evalString({
                javascriptString: "console.log('success!!!')",
              });
            }}
            title="send message to cocos"
          />
        </View>
        <View style={{ margin: 16 }}>
          <Button
            onPress={() => {
              evalString({
                javascriptString: "cc.postMessageToReactNative('success!')",
              });
            }}
            title="get message from cocos"
          />
        </View>
        <Text>{log}</Text>
        <View style={{ margin: 16 }}>
          <Button
            onPress={() => {
              setIsCocosVisible((origin) => !origin);
              if (isCocosVisible) {
                Cocos2dxGLViewModule.onPause();
              } else {
                Cocos2dxGLViewModule.onResume();
              }
            }}
            title={(isCocosVisible ? 'remove' : 'add') + ' Cocos2dxGLView'}
          />
        </View>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'white',
    // alignItems: 'center',
    // justifyContent: 'center',
  },
  box: {
    flex: 1,
    // width: '100%',
    // height: '100%'
  },
});
