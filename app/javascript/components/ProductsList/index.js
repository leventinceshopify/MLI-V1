import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import { useQuery } from '@apollo/react-hooks';

import {products} from "./operations.graphql";
import cs from './styles';
import '@shopify/polaris/styles.css';

// import './styles.module.css'

function ProductsList  ({ onProductSelected }) {
  const { loading, error, data } = useQuery(products);

    if (loading) return 'Loading...';
    if (error) return `Error! ${error.message}`;

    return (

      <select name="product" onChange={onProductSelected} style={{width: '200px', height: '25px'}}>
        <option>
          Select a Product
        </option>
        {data.allProducts.map(product => (
          <option key={product.id} value={product.id}>
            {product.name}
          </option>
        ))}
      </select>
    );
}


export default ProductsList;
// export default {VariantsList, ItemsofVariant};
