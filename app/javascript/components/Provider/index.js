// This is a design pattern.  Create a provider and put the components in it
// Bind this provider with the Apollo client

import React from 'react';
import { ApolloProvider } from 'react-apollo';
import { createCache, createClient } from '../../utils/apollo';

export default ({ children }) => (
  <ApolloProvider client={createClient(createCache())}>
    {children}
  </ApolloProvider>
);
