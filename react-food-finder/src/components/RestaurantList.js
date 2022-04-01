import React, { useContext } from 'react';
import { FlatList } from 'react-native';
import { getDistance } from 'geolib';

import { LocationContext } from '../context/LocationContext';
import { metersToMiles } from '../utils/distance-convertor';

import RestaurantCard from './RestaurantCard';

const RestaurantList = ({ restaurants, style = {} }) => {
  const { location } = useContext(LocationContext);

  return (
    <FlatList
      data={restaurants}
      renderItem={({ item: restaurant }) => {
        const { latitude, longitude } = location;

        const distance = metersToMiles(
          getDistance({ latitude, longitude }, { ...restaurant.coordinates })
        ).toFixed(2);

        return <RestaurantCard restaurant={restaurant} distance={distance} />;
      }}
      keyExtractor={({ id }) => id}
      style={style}
    />
  );
};

export default RestaurantList;
