import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import { useQuery } from '@apollo/react-hooks';
import {listItemsofVariant} from "./operations.graphql";
// import VariantsList from '../VariantsList';
import cs from './styles';
import '@shopify/polaris/styles.css';

function ItemsOfVariant ({ id }) {


  const { loading, error, data } = useQuery(listItemsofVariant, { variables: { id }});

    if (loading) return null;
    if (error) return `Error! ${error}`;

    return (
      <ul>

        {data.variant.items.map(item => (
          <li key={item.id}>{item.name}</li>
        ))}
      </ul>

    );

}




export default  ItemsOfVariant;
