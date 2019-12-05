import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import { useQuery } from '@apollo/react-hooks';

import {locations} from "./operations.graphql";
import cs from './styles';
import '@shopify/polaris/styles.css';

// import './styles.module.css'

function LocationsList  ({ onLocationSelected }) {
  const { loading, error, data } = useQuery(locations);

    if (loading) return 'Loading...';
    if (error) return `Error! ${error.message}`;

    return (

      <select name="location" onChange={onLocationSelected}>
        {data.allLocations.map(location => (
          <option key={location.id} value={location.id}>
            {location.name}
          </option>
        ))}
      </select>
    );
}

// function ItemsofVariant ({ name }) {
//   const { loading, error, data } = useQuery(ItemsOfVariant, {
//     variables: { name },
//   });
//
//     if (loading) return null;
//     if (error) return `Error! ${error}`;
//
//     return (
//       <ul>
//         {data.variant.items.map(item => (
//           <li key={item.id}>{item.name}</li>
//         ))}
//       </ul>
//
//     );
//
// }
//


export default LocationsList;
// export default {VariantsList, ItemsofVariant};
