import React, { useContext } from 'react';
import { View } from 'react-native';
import Constants from 'expo-constants';
import Icon from 'react-native-vector-icons/MaterialCommunityIcons';

import MapboxGL from '@react-native-mapbox-gl/maps';
import '../utils/mapbox-logger';

import { LocationContext } from '../context/LocationContext';
import { RestaurantContext } from '../context/RestaurantContext';

MapboxGL.setAccessToken(Constants.manifest.extra.MAPBOX_ACCESS_TOKEN);

const MapScreen = () => {
  const { location } = useContext(LocationContext);
  const { restaurants } = useContext(RestaurantContext);

  // Extracts latitude and longitude from each restaurant and inserts into a new array
  const markers = restaurants.map(({ coordinates }) => [
    coordinates.longitude,
    coordinates.latitude,
  ]);

  return (
    <MapboxGL.MapView style={{ flex: 1 }}>
      <MapboxGL.Camera
        zoomLevel={12}
        centerCoordinate={[location.longitude, location.latitude]}
      />
      {markers.map((coords) => (
        <MapboxGL.MarkerView coordinate={coords} key={coords.join()}>
          <View style={{ width: 42, height: 42 }}>
            <Icon name="map-marker" size={42} color="#FF9800" />
          </View>
        </MapboxGL.MarkerView>
      ))}
    </MapboxGL.MapView>
  );
};

export default MapScreen;
