import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import { useQuery } from '@apollo/react-hooks';

import {items} from "./operations.graphql";
import cs from './styles';
import '@shopify/polaris/styles.css';

// import './styles.module.css'

function ItemsList  ({ onItemSelected }) {
  const { loading, error, data } = useQuery(items);

    if (loading) return 'Loading...';
    if (error) return `Error! ${error.message}`;

    return (

      <select name="item" onChange={onItemSelected} style={{width: '200px', height: '25px'}}>
        <option>
          Select an Item
        </option>
        {data.allItems.map(item => (
          <option key={item.id} value={item.id}>
            {item.name}
          </option>
        ))}
      </select>
    );
}

export default ItemsList;
