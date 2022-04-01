import Constants from 'expo-constants';

const url = 'https://api.yelp.com/v3/businesses';
const headers = {
  Authorization: `Bearer ${Constants.manifest.extra.YELP_AUTH_TOKEN}`,
};

export const getRestaurants = async ({ lat, lng }) => {
  const response = await fetch(
    `${url}/search?term=food&latitude=${lat}&longitude=${lng}&limit=15`,
    { headers }
  );

  if (response.status !== 200) {
    throw new Error('Could not retrieve restaurant data. Please try again');
  }

  const data = await response.json();

  return data?.businesses || [];
};

export const getRestaurantById = async (id) => {
  const response = await fetch(`${url}/${id}`, { headers });

  if (response.status !== 200) {
    return null;
  }

  return await response.json();
};
