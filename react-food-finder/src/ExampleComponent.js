import React, { useState } from 'react';

const ExampleComponent = () => {
  const [message, setMessage] = useState('Hello World');

  return <Text>{message}</Text>;
};

export default ExampleComponent;
