import React, { useContext, useState } from 'react';
import { TextInput } from 'react-native-paper';

import { LocationContext } from '../context/LocationContext';
import { RestaurantContext } from '../context/RestaurantContext';

import RestaurantList from '../components/RestaurantList';
import Container from '../components/Container';

const Home = () => {
  const { setLocationGPS, setLocationAddress } = useContext(LocationContext);
  const { restaurants, loading } = useContext(RestaurantContext);

  const [address, setAddress] = useState('');

  const handleSubmit = () => {
    // If search is empty set location to GPS as default
    address ? setLocationAddress(address) : setLocationGPS();
  };

  return (
    <Container>
      <TextInput
        label="Enter Location"
        value={address}
        onChangeText={(address) => setAddress(address)}
        onSubmitEditing={handleSubmit}
        style={{ marginBottom: 12 }}
      />
      {!loading && <RestaurantList restaurants={restaurants} />}
    </Container>
  );
};

export default Home;
