import { StatusBar } from 'expo-status-bar';
import { View } from 'react-native';
import { Provider as PaperProvider, DefaultTheme } from 'react-native-paper';
import Toast from 'react-native-toast-message';
import {
  useFonts,
  OpenSans_700Bold,
  OpenSans_400Regular,
} from '@expo-google-fonts/open-sans';

import { LocationProvider } from './src/context/LocationContext';
import { RestaurantProvider } from './src/context/RestaurantContext';
import { FavouritesProvider } from './src/context/FavouritesContext';

import Navigation from './src/components/Navigation';

export default App = () => {
  const [fontsLoading] = useFonts({ OpenSans_700Bold, OpenSans_400Regular });

  if (!fontsLoading) {
    return <View></View>;
  }

  return (
    <>
      <LocationProvider>
        <RestaurantProvider>
          <FavouritesProvider>
            <PaperProvider theme={DefaultTheme}>
              <StatusBar />
              <Navigation />
            </PaperProvider>
          </FavouritesProvider>
        </RestaurantProvider>
      </LocationProvider>
      <Toast />
    </>
  );
};
