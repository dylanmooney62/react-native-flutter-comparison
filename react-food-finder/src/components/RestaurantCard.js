import React, { useContext } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { IconButton } from 'react-native-paper';
import Icon from 'react-native-vector-icons/MaterialCommunityIcons';

import { FavouritesContext } from '../context/FavouritesContext';

import ImageGradient from './ImageGradient';
import Rating from './Rating';

const placeholderImg = 'https://picsum.photos/id/163/400/300';

const RestaurantCard = ({ restaurant, distance }) => {
  const { favourites, addFavourite, removeFavourite } =
    useContext(FavouritesContext);

  const { id, name, image_url, location, rating } = restaurant;

  const isFavourite = favourites.some((r) => r.id === id);

  const handlePress = () => {
    !isFavourite ? addFavourite(restaurant) : removeFavourite(restaurant);
  };

  return (
    <View style={styles.card}>
      <View style={styles.header}>
        <View style={styles.distance}>
          <Icon name="navigation" color="white" size={16} />
          <Text style={styles.distanceText}>{distance}m</Text>
        </View>
        <View style={styles.favourite}>
          <IconButton
            icon={isFavourite ? 'heart' : 'heart-outline'}
            color={isFavourite ? 'red' : 'white'}
            size={36}
            onPress={handlePress}
          />
        </View>
        <ImageGradient src={image_url ? image_url : placeholderImg} />
      </View>
      <View style={styles.body}>
        <View style={{ flex: 1 }}>
          <Text style={styles.title}>{name}</Text>
          <Text style={styles.address}>{location.address1}</Text>
        </View>
        <Rating value={Math.floor(rating)} />
      </View>
    </View>
  );
};

export default RestaurantCard;

const styles = StyleSheet.create({
  card: {
    backgroundColor: 'white',
    borderColor: '#E0E0E0',
    overflow: 'hidden',
    borderRadius: 10,
    marginBottom: 16,
  },
  header: {
    position: 'relative',
    height: 200,
  },
  favourite: {
    position: 'absolute',
    top: -6,
    left: -6,
    zIndex: 300,
  },
  distance: {
    display: 'flex',
    flexDirection: 'row',
    position: 'absolute',
    alignItems: 'center',
    right: 0,
    top: 0,
    zIndex: 300,
    padding: 12,
  },
  distanceText: {
    color: 'white',
    fontFamily: 'OpenSans_400Regular',
    fontSize: 16,
    marginLeft: 12,
  },
  body: {
    display: 'flex',
    flexDirection: 'row',
    justifyContent: 'space-between',
    padding: 16,
  },
  address: {
    fontFamily: 'OpenSans_400Regular',
    flex: 1,
  },
  title: {
    fontSize: 16,
    marginBottom: 8,
    fontFamily: 'OpenSans_700Bold',
  },
});
