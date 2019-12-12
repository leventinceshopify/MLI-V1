import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import { useQuery, useMutation } from '@apollo/react-hooks';

import {createProduct, deleteProduct, updateProduct, showProductInfo} from "./operations.graphql";

import ProductsList from '../ProductsList'
import DefinitionsProduct from '../DefinitionsProduct'
import DefinitionsVariant from '../DefinitionsVariant'
import DefinitionsItem from '../DefinitionsItem'
import DefinitionsItemVariantBind from '../DefinitionsItemVariantBind'
import DefinitionsInventoryItemConditionAndState from '../DefinitionsInventoryItemConditionAndState'
import {Button} from '@shopify/polaris';



import cs from './styles';
import '@shopify/polaris/styles.css';



const columnClass = {
  float: 'left',
  width: '15%',
  padding: '10px',
  height: '300px'
}






function DefinitionsPanel() {


  return (

    <div >


      <div style={columnClass}>
        <DefinitionsProduct />
    </div>
    
    <div style={columnClass}>
      <DefinitionsVariant />
    </div>

    <div style={columnClass}>
      <DefinitionsItem />
    </div>

    <div style={columnClass}>
      <DefinitionsItemVariantBind />
    </div>
    <div style={columnClass}>
      <DefinitionsInventoryItemConditionAndState />
    </div>



</div>


);

}





export default DefinitionsPanel;
// export default {VariantsList, ItemsofVariant};
