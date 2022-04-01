import 'dotenv/config';

const MAPBOX_ACCESS_TOKEN = process.env.MAPBOX_ACCESS_TOKEN;
const YELP_AUTH_TOKEN = process.env.YELP_AUTH_TOKEN;

export default ({ config }) => {
  return {
    ...config,
    extra: {
      MAPBOX_ACCESS_TOKEN,
      YELP_AUTH_TOKEN,
    },
  };
};
