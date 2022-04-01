import React, { createContext, useCallback, useEffect, useState } from 'react';
import * as Location from 'expo-location';
import Toast from 'react-native-toast-message';

export const LocationContext = createContext();

export const LocationProvider = ({ children }) => {
  const [location, setLocation] = useState(null);
  const [loading, setLoading] = useState(false);

  // Use GPS location when app loads
  useEffect(() => {
    setLocationGPS();
  }, [setLocationGPS]);

  const setLocationGPS = useCallback(async () => {
    setLoading(true);

    const { status } = await Location.requestForegroundPermissionsAsync();

    if (status !== 'granted') {
      return handleError('Location permissions are denied');
    }

    try {
      const { coords } = await Location.getCurrentPositionAsync({});

      const { latitude, longitude } = coords;

      setLocation({ latitude, longitude });
      setLoading(false);
    } catch (error) {
      handleError(error.message);
    }
  }, []);

  const setLocationAddress = async (address) => {
    setLoading(true);

    try {
      const locations = await Location.geocodeAsync(address);

      const { latitude, longitude } = locations[0];

      if (locations.length === 0) {
        return handleError('Could not retrieve location from address');
      }

      setLocation({ latitude, longitude });
      setLoading(false);
    } catch (error) {
      return handleError('Could not retrieve location from address');
    }
  };

  const handleError = (message) => {
    Toast.show({ type: 'error', text1: message });
    setLocation({ latitude: 51.509865, longitude: -0.118092 });
    setLoading(false);
  };

  return (
    <LocationContext.Provider
      value={{ location, loading, setLocationAddress, setLocationGPS }}
    >
      {children}
    </LocationContext.Provider>
  );
};
