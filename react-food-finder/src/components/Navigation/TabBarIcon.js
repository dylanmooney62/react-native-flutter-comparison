import { IconButton } from 'react-native-paper';

const TabBarIcon = ({ icon, focused }) => (
  <IconButton icon={icon} color={focused ? '#757575' : '#424242'} />
);

export default TabBarIcon;
