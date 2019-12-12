import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import { useQuery, useMutation } from '@apollo/react-hooks';

import {createInventoryItemCondition, deleteInventoryItemCondition, createInventoryItemState, deleteInventoryItemState} from "./operations.graphql";

import InventoryItemConditionsList from '../InventoryItemConditionsList';
import InventoryItemStatesList from '../InventoryItemStatesList';

import {Button} from '@shopify/polaris';

import cs from './styles';
import '@shopify/polaris/styles.css';



function DefinitionsInventoryItemConditionAndState() {

  const [inventoryItemConditionName, setInventoryItemConditionName] = useState("");
  const [inventoryItemStateName, setInventoryItemStateName] = useState("");

  const [selectedInventoryItemCondition, setSelectedInventoryItemCondition] = useState(null);
  const [selectedInventoryItemState, setSelectedInventoryItemState] = useState(null);

  const [createInventoryItemCond] = useMutation(createInventoryItemCondition);
  const [deleteInventoryItemCond] = useMutation(deleteInventoryItemCondition);
  const [createInventoryItemStat] = useMutation(createInventoryItemState);
  const [deleteInventoryItemStat] = useMutation(deleteInventoryItemState);


// const { loading, error, data } = useQuery(showProductInfo, { variables: { id: selectedProduct }});

  function onInventoryItemConditionNameEntered({ target }) {

    setInventoryItemConditionName(target.value);
    console.log(inventoryItemConditionName);
  }
  function onInventoryItemStateNameEntered({ target }) {

    setInventoryItemStateName(target.value);
    console.log(inventoryItemStateName);
  }


  function onInventoryItemConditionSelected({ target }) {

    setSelectedInventoryItemCondition(target.value);
    console.log(selectedInventoryItemCondition);
  }

  function onInventoryItemStateSelected({ target }) {

    setSelectedInventoryItemState(target.value);
    console.log(selectedInventoryItemState);
  }


  return (

    <div >

      <form style={{ width: '210px', borderRadius: '5px',backgroundColor: '#a9f2f9',padding: '5px'}}>
        <h1 style={{width: '200px', textAlign: 'center'}}><b>Create Condition</b></h1>

        Name <br />
        <input name="itemName" type="text" style={{width: '200px', height: '25px'}}
          onChange={onInventoryItemConditionNameEntered}></input> <br/>

          <button className="Polaris-Button Polaris-Button--primary" onClick={e => {
              e.preventDefault();

              createInventoryItemCond({ variables: {  name: inventoryItemConditionName} });
              window.location.reload();
            }}   type="submit" style={{width: '200px', height: '25px'}}>Create Condition</button>


        </form>
        <br/>


          <form style={{ width: '210px', borderRadius: '5px',backgroundColor: '#a9f2f9',padding: '5px'}}>
            <h1 style={{width: '200px', textAlign: 'center'}}><b>Delete Condition</b></h1>

      <InventoryItemConditionsList onInventoryItemConditionSelected={onInventoryItemConditionSelected} />

      <button className="Polaris-Button Polaris-Button--destructive" onClick={e => {
          e.preventDefault();
          deleteInventoryItemCond({ variables: { name: selectedInventoryItemCondition} });
          window.location.reload();
        }}   type="submit" style={{width: '200px', height: '25px'}}>Delete Condition</button>
    </form>

    <br/>
    <br/>
    <br/>

      <form style={{ width: '210px', borderRadius: '5px',backgroundColor: '#a9f2f9',padding: '5px'}}>
        <h1 style={{width: '200px', textAlign: 'center'}}><b>Create State</b></h1>

        Name <br />
        <input name="itemName" type="text" style={{width: '200px', height: '25px'}}
          onChange={onInventoryItemStateNameEntered}></input> <br/>

          <button className="Polaris-Button Polaris-Button--primary" onClick={e => {
              e.preventDefault();

              createInventoryItemStat({ variables: {  name: inventoryItemStateName} });
              window.location.reload();
            }}   type="submit" style={{width: '200px', height: '25px'}}>Create State</button>

        </form>
        <br/>


          <form style={{ width: '210px', borderRadius: '5px',backgroundColor: '#a9f2f9',padding: '5px'}}>
            <h1 style={{width: '200px', textAlign: 'center'}}><b>Delete State</b></h1>


        <InventoryItemStatesList onInventoryItemStateSelected={onInventoryItemStateSelected} />

        <button className="Polaris-Button Polaris-Button--destructive" onClick={e => {
          e.preventDefault();
          deleteInventoryItemStat({ variables: { name: selectedInventoryItemState} });
          window.location.reload();
        }}   type="submit" style={{width: '200px', height: '25px'}}>Delete State</button>

    </form>
    </div>

);

}

export default DefinitionsInventoryItemConditionAndState;
// export default {VariantsList, ItemsofVariant};
