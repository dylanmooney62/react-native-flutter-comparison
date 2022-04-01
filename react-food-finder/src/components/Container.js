import React from 'react';
import { View } from 'react-native';

const Container = ({ children }) => (
  <View style={{ padding: 12, backgroundColor: '#EEEEEE', flex: 1 }}>
    {children}
  </View>
);

export default Container;
