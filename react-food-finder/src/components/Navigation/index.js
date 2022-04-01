import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';

import HomeScreen from '../../screens/HomeScreen';
import MapScreen from '../../screens/MapScreen';
import FavouritesScreen from '../../screens/FavouritesScreen';

import TabBarIcon from './TabBarIcon';

const Tab = createBottomTabNavigator();

const screenOptions = {
  tabBarStyle: {
    height: 64,
  },
  headerStyle: {
    backgroundColor: 'transparent',
    boxShadow: 'none',
    elevation: 0,
  },
  headerTitleStyle: {
    fontSize: 24,
    fontFamily: 'OpenSans_700Bold',
  },
  tabBarHideOnKeyboard: true,
  tabBarShowLabel: false,
};

const Navigation = () => (
  <NavigationContainer>
    <Tab.Navigator screenOptions={screenOptions}>
      <Tab.Screen
        name="FoodFinder"
        component={HomeScreen}
        options={{
          tabBarIcon: ({ focused }) => (
            <TabBarIcon icon="home" focused={focused} />
          ),
        }}
      />
      <Tab.Screen
        name="Map"
        component={MapScreen}
        options={{
          headerShown: false,
          tabBarIcon: ({ focused }) => (
            <TabBarIcon icon="map" focused={focused} />
          ),
        }}
      />
      <Tab.Screen
        name="Favourites"
        component={FavouritesScreen}
        options={{
          tabBarIcon: ({ focused }) => (
            <TabBarIcon icon="heart" focused={focused} />
          ),
        }}
      />
    </Tab.Navigator>
  </NavigationContainer>
);

export default Navigation;
