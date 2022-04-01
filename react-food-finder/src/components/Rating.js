import React from 'react';
import { View } from 'react-native';
import Icon from 'react-native-vector-icons/MaterialCommunityIcons';

const Rating = ({ value = 0 }) => (
  <View style={{ display: 'flex', flexDirection: 'row' }}>
    {Array(value)
      .fill()
      .map((_, i) => (
        <Icon name="star" size={23} color="#FFC107" key={i} />
      ))}
  </View>
);

export default Rating;
