import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import { useQuery } from '@apollo/react-hooks';

import {inventoryItemConditions} from "./operations.graphql";
import cs from './styles';
import '@shopify/polaris/styles.css';

function InventoryItemConditionsList  ({ onInventoryItemConditionSelected }) {
  const { loading, error, data } = useQuery(inventoryItemConditions);

    if (loading) return 'Loading...';
    if (error) return `Error! ${error.message}`;

    return (

      <select name="inventory_item_condition" onChange={onInventoryItemConditionSelected} style={{width: '200px', height: '25px'}}>
        <option>
          Select a Condition
        </option>
        {data.allInventoryItemConditions.map(inventory_item_condition => (
          <option key={inventory_item_condition.id} value={inventory_item_condition.name}>
            {inventory_item_condition.name}
          </option>
        ))}
      </select>
    );
}

export default InventoryItemConditionsList;
