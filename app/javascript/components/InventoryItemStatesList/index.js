import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import { useQuery } from '@apollo/react-hooks';

import {inventoryItemStates} from "./operations.graphql";
import cs from './styles';
import '@shopify/polaris/styles.css';

// import './styles.module.css'

function InventoryItemStatesList  ({ onInventoryItemStateSelected }) {
  const { loading, error, data } = useQuery(inventoryItemStates);

    if (loading) return 'Loading...';
    if (error) return `Error! ${error.message}`;

    return (

      <select name="inventory_item_state" onChange={onInventoryItemStateSelected} style={{width: '200px', height: '25px'}}>
        <option>
          Select a State
        </option>
        {data.allInventoryItemStates.map(inventory_item_state => (
          <option key={inventory_item_state.id} value={inventory_item_state.name}>
            {inventory_item_state.name}
          </option>
        ))}
      </select>
    );
}

export default InventoryItemStatesList;
