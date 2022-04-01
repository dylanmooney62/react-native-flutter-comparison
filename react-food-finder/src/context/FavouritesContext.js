import React, { createContext, useState } from 'react';
import { useAsyncStorage } from '@react-native-async-storage/async-storage';
import useAsyncEffect from 'use-async-effect';

import { getRestaurantById } from '../api/yelp';

export const FavouritesContext = createContext();

export const FavouritesProvider = ({ children }) => {
  const [favourites, setFavourites] = useState([]);
  const { getItem, setItem } = useAsyncStorage('@favourites');

  // Load favourites on initial render
  useAsyncEffect(async () => {
    // Favourites are stored as id's to retrieve update to data restaurant data from API
    const ids = JSON.parse(await getItem());

    if (!ids || ids.length === 0) return;

    // Make a request for each id in the array
    const restaurants = await Promise.all(
      ids.map((id) => getRestaurantById(id))
    );

    setFavourites(restaurants.filter((r) => r !== null));
  }, []);

  // Runs every time user adds or removes favourite
  useAsyncEffect(async () => {
    const ids = favourites.map(({ id }) => id);
    // Store updated id's in key storage
    await setItem(JSON.stringify(ids));
  }, [favourites]);

  const addFavourite = (restaurant) => {
    setFavourites((faves) => [...faves, restaurant]);
  };

  const removeFavourite = async (restaurant) => {
    setFavourites((faves) => faves.filter(({ id }) => id !== restaurant.id));
  };

  return (
    <FavouritesContext.Provider
      value={{ favourites, addFavourite, removeFavourite }}
    >
      {children}
    </FavouritesContext.Provider>
  );
};
