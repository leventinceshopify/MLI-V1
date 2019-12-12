import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import { useQuery } from '@apollo/react-hooks';

import cs from './styles';
import '@shopify/polaris/styles.css';

// import './styles.module.css'

function CountList  ({ onCountSelected }) {


    return (

      <select name="count" onChange={onCountSelected} style={{width: '200px', height: '25px'}}>
        <option>
          Select a Quantity
        </option>
        {[...Array(100).keys()].map(c => (
          <option key={c} value={Number(c)}>
            {c}
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


export default CountList;
// export default {VariantsList, ItemsofVariant};
