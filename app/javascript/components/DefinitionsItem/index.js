import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import { useQuery, useMutation } from '@apollo/react-hooks';

import {createItem, deleteItem, updateItem} from "./operations.graphql";

import ItemsList from '../ItemsList';

import {Button} from '@shopify/polaris';



import cs from './styles';
import '@shopify/polaris/styles.css';






function DefinitionsItem() {

  const [itemName, setItemName] = useState("");
  const [itemDescription, setItemDescription] = useState("");
  // const [itemSKU, setItemSKU] = useState("");
  const [itemCost, setItemCost] = useState("");
  const [itemQuantityThreshold, setItemQuantityThreshold] = useState("");
  const [selectedItem, setSelectedItem] = useState(null);

  const [createIte] = useMutation(createItem);
  const [deleteIte] = useMutation(deleteItem);
  const [updateIte] = useMutation(updateItem);
  // const [updateIte] = useMutation(updateItem);


// const { loading, error, data } = useQuery(showProductInfo, { variables: { id: selectedProduct }});

  function onItemNameEntered({ target }) {

    setItemName(target.value);
    console.log(itemName);
  }
  function onItemDescriptionEntered({ target }) {

    setItemDescription(target.value);
    console.log(itemDescription);
  }

  function onItemCostEntered({ target }) {

    setItemCost(target.value);
    console.log(itemCost);
  }

  function onItemQuantityThresholdEntered({ target }) {

    setItemQuantityThreshold(target.value);
    console.log(itemQuantityThreshold);
  }

  function onItemSelected({ target }) {

    setSelectedItem(target.value);
    console.log(selectedItem);
  }


  return (

    <div >

      <form style={{ width: '210px', borderRadius: '5px',backgroundColor: '#a9f2f9',padding: '5px'}}>
        <h1 style={{width: '200px', textAlign: 'center'}}><b>Create Item</b></h1>

          Name <br />
        <input name="itemName" type="text" style={{width: '200px', height: '25px'}}
          onChange={onItemNameEntered}></input> <br/>

        Cost <br />
      <input name="itemCost" type="text" style={{width: '200px', height: '25px'}}
          onChange={onItemCostEntered}></input> <br/>

        Quantity TH <br />
      <input name="itemQTH" type="text" style={{width: '200px', height: '25px'}}
            onChange={onItemQuantityThresholdEntered}></input> <br/>
        Description<br />
      <textarea name="description" rows="5" cols="30"
        onChange={onItemDescriptionEntered}> ></textarea><br/>

      <button className="Polaris-Button Polaris-Button--primary" onClick={e => {
          e.preventDefault();
          createIte({ variables: {sku: parseInt(100),  name: itemName,  description: itemDescription, quantityThreshold: parseInt(itemQuantityThreshold), cost: parseFloat(itemCost), size: "", manufacturer: "Japan", picture: ""} });
          window.location.reload();
        }}   type="submit" style={{width: '200px', height: '25px'}}>Create Item</button>

    </form>

        <br/>
        <br/>

          <form style={{ width: '210px', borderRadius: '5px',backgroundColor: '#a9f2f9',padding: '5px'}}>
            <h1 style={{width: '200px', textAlign: 'center'}}><b>Delete Item</b></h1>

        <ItemsList onItemSelected={onItemSelected} />
        <button className="Polaris-Button Polaris-Button--destructive" onClick={e => {
            e.preventDefault();
            deleteIte({ variables: { id: selectedItem} });
            window.location.reload();
          }}   type="submit" style={{width: '200px', height: '25px'}}>Delete Item</button>

    </form>

    <br/>
    <br/>

      <form style={{ width: '210px', borderRadius: '5px',backgroundColor: '#a9f2f9',padding: '5px'}}>
        <h1 style={{width: '200px', textAlign: 'center'}}><b>Update Item</b></h1>
        <ItemsList onItemSelected={onItemSelected} />

          Name <br />
        <input name="itemName" type="text" style={{width: '200px', height: '25px'}}
          onChange={onItemNameEntered}></input> <br/>

        Cost <br />
        <input name="itemCost" type="text" style={{width: '200px', height: '25px'}}
          onChange={onItemCostEntered}></input> <br/>

        Quantity TH <br />
        <input name="itemQTH" type="text" style={{width: '200px', height: '25px'}}
            onChange={onItemQuantityThresholdEntered}></input> <br/>
        Description<br />
        <textarea name="description" rows="5" cols="30"
        onChange={onItemDescriptionEntered}> ></textarea><br/>

        <button className="Polaris-Button Polaris-Button--primary" onClick={e => {
          e.preventDefault();
          updateIte({ variables: {id: parseInt(selectedItem), sku: parseInt(100),  name: itemName,  description: itemDescription, quantityThreshold: parseInt(itemQuantityThreshold), cost: parseFloat(itemCost), size: "", manufacturer: "Japan", picture: ""} });
          window.location.reload();
        }}   type="submit" style={{width: '200px', height: '25px'}}>Update Item</button>



</form>
    </div>



);

}






export default DefinitionsItem;
// export default {VariantsList, ItemsofVariant};
