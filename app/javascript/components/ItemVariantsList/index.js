import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import { useQuery } from '@apollo/react-hooks';

import {itemVariants} from "./operations.graphql";
import cs from './styles';
import '@shopify/polaris/styles.css';

// import './styles.module.css'

function ItemVariantsList  ({ onItemVariantSelected }) {
  const { loading, error, data } = useQuery(itemVariants);

    if (loading) return 'Loading...';
    if (error) return `Error! ${error.message}`;

    return (

      <select  name="itemvariant" onChange={onItemVariantSelected} style={{width: '200px', height: '25px'}}>
        <option>
          Select a Item-Variant
        </option>
        {data.allItemVariants.map(iv => (
          <option key={location.id} value={iv.id}>
          {iv.variant.name} : {iv.item.name}
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


export default ItemVariantsList;
// export default {VariantsList, ItemsofVariant};
