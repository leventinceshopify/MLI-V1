import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import { useQuery } from '@apollo/react-hooks';

import {variants} from "./operations.graphql";
import cs from './styles';
import '@shopify/polaris/styles.css';


function VariantsList  ({ onVariantSelected }) {
  const { loading, error, data } = useQuery(variants);

    if (loading) return 'Loading...';
    if (error) return `Error! ${error.message}`;

    return (

      <select name="variant" onChange={onVariantSelected} style={{width: '200px', height: '25px'}}>
        <option>
          Select a Variant
        </option>
        {data.allVariants.map(variant => (
          <option key={variant.id} value={variant.id}>
            {variant.name}
          </option>
        ))}
      </select>


    );
}
export default VariantsList;
