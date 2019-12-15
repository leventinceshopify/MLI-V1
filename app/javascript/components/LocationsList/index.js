import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import { useQuery } from '@apollo/react-hooks';

import {locations} from "./operations.graphql";
import cs from './styles';
import '@shopify/polaris/styles.css';

function LocationsList  ({ onLocationSelected }) {
  const { loading, error, data } = useQuery(locations);

    if (loading) return 'Loading...';
    if (error) return `Error! ${error.message}`;

    return (

      <select  name="location" onChange={onLocationSelected} style={{width: '200px', height: '25px'}}>
        <option>
          Select a Location
        </option>
        {data.allLocations.map(location => (
          <option key={location.id} value={location.id}>
            {location.name}
          </option>
        ))}
      </select>

    );
}

export default LocationsList;
