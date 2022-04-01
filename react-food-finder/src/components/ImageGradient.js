import React from 'react';
import { Image, StyleSheet, View } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';

const ImageGradient = ({ src }) => (
  <View style={{ flex: 1, position: 'relative' }}>
    <LinearGradient
      style={styles.gradient}
      colors={['rgba(0,0,0,0.66)', 'rgba(0,0,0,0.66)']}
    />
    <Image style={{ resizeMode: 'cover', flex: 1 }} source={{ uri: src }} />
  </View>
);

export default ImageGradient;

const styles = StyleSheet.create({
  gradient: {
    position: 'absolute',
    left: 0,
    right: 0,
    zIndex: 200,
    height: '100%',
  },
});
