import React, { useContext } from 'react';

import { FavouritesContext } from '../context/FavouritesContext';
import { LocationContext } from '../context/LocationContext';

import Container from '../components/Container';
import RestaurantList from '../components/RestaurantList';

const FavouritesScreen = () => {
  const { favourites } = useContext(FavouritesContext);
  const { location } = useContext(LocationContext);

  return (
    <Container>
      {location && <RestaurantList restaurants={favourites} />}
    </Container>
  );
};

export default FavouritesScreen;
