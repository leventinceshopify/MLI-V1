import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import { useQuery, useMutation } from '@apollo/react-hooks';

import {sellVariantFromLocation, cancelVariantSaleFromLocation, shipVariantFromLocation, markLost, transfer} from "./operations.graphql";
import {orderItemToLocation, shipItemToLocation, acceptAtLocation, removeOrderFromLocation, returnVariantToLocation} from "./operations.graphql";

import ItemsOfVariant from '../ItemsOfVariant';
import VariantsList from '../VariantsList'
import ItemsList from '../ItemsList'
import LocationsList from '../LocationsList'
import InventoryItemConditionsList from '../InventoryItemConditionsList'
import InventoryItemStatesList from '../InventoryItemStatesList'
import CountList from '../CountList'


import {Button} from '@shopify/polaris';
import { Card, DataTable, Page } from "@shopify/polaris";


import cs from './styles';
import '@shopify/polaris/styles.css';

function QueryPanel() {

  const [selectedVariant, setSelectedVariant] = useState(null);
  const [selectedLocation, setSelectedLocation] = useState(null);
  const [selectedLocation2, setSelectedLocation2] = useState(null);
  const [selectedInventoryItemCondition, setSelectedInventoryItemCondition] = useState(null);
  const [selectedInventoryItemState, setSelectedInventoryItemState] = useState(null);
  const [selectedItem, setSelectedItem] = useState(null);
  const [selectedCount, setSelectedCount] = useState(null);

  const [sellVariant] = useMutation(sellVariantFromLocation);
  const [cancelVariantSale] = useMutation(cancelVariantSaleFromLocation);
  const [shipVariant] = useMutation(shipVariantFromLocation);
  const [orderItem] = useMutation(orderItemToLocation);
  const [shipItemToLoc] = useMutation(shipItemToLocation);
  const [acceptItemAtLoc] = useMutation(acceptAtLocation);
  const [removeOrderFromLoc] = useMutation(removeOrderFromLocation);
  const [returnVariantToLoc] = useMutation(returnVariantToLocation);
  const [markItemLost] = useMutation(markLost);
  const [transferItem] = useMutation(transfer);


    function onVariantSelected({ target }) {

      setSelectedVariant(target.value);
      console.log(selectedVariant);
    }

    function onItemSelected({ target }) {

      setSelectedItem(target.value);
      console.log(selectedItem);
    }

    function onLocationSelected({ target }) {

      setSelectedLocation(target.value);
      console.log(selectedLocation);
    }

    function onLocation2Selected({ target }) {

      setSelectedLocation2(target.value);
      console.log(selectedLocation);
    }


    function onInventoryItemConditionSelected({ target }) {

      setSelectedInventoryItemCondition(target.value);
      console.log(selectedInventoryItemCondition);
    }

    function onInventoryItemStateSelected({ target }) {

      setSelectedInventoryItemState(target.value);
      console.log(selectedInventoryItemState);
    }

    function onCountSelected({ target }) {
      setSelectedCount(target.value);
      console.log(selectedCount);
    }

    return (


        <div >
      <form style={{ width: "100%"}}>
          <VariantsList onVariantSelected={onVariantSelected} />{selectedVariant && <ItemsOfVariant id={selectedVariant}  />}  <LocationsList onLocationSelected={onLocationSelected} /> <InventoryItemConditionsList onInventoryItemConditionSelected={onInventoryItemConditionSelected} /> <br/>

             <button className="Polaris-Button Polaris-Button--primary" onClick={e => {
               e.preventDefault();
               sellVariant({ variables: { variantId: parseInt(selectedVariant),  locationId: parseInt(selectedLocation), inventoryItemConditionName: selectedInventoryItemCondition} });
               window.location.reload();
             }}   type="submit">Sell Variant</button>
             <button className="Polaris-Button Polaris-Button--destructive" onClick={e => {
               e.preventDefault();
               cancelVariantSale({ variables: { variantId: parseInt(selectedVariant),  locationId: parseInt(selectedLocation), inventoryItemConditionName: selectedInventoryItemCondition} });
               window.location.reload();
             }}   type="submit">Cancel Sale</button>

             <button className="Polaris-Button Polaris-Button--primary" onClick={e => {
               e.preventDefault();
               shipVariant({ variables: { variantId: selectedVariant,  locationId: selectedLocation} });
               window.location.reload();
             }}   type="submit">Ship Variant</button>

             <button className="Polaris-Button Polaris-Button--primary" onClick={e => {
               e.preventDefault();
               returnVariantToLoc({ variables: { variantId: parseInt(selectedVariant),  locationId: parseInt(selectedLocation), inventoryItemConditionName: selectedInventoryItemCondition} });
               window.location.reload();
             }}   type="submit">Return Variant</button>


         </form>

         <form style={{ width: "100%"}}>
           <ItemsList  onItemSelected={onItemSelected} />   <LocationsList onLocationSelected={onLocationSelected} /> <InventoryItemConditionsList onInventoryItemConditionSelected={onInventoryItemConditionSelected} />
       <InventoryItemStatesList onInventoryItemStateSelected={onInventoryItemStateSelected} /><CountList onCountSelected={onCountSelected}/><LocationsList onLocationSelected={onLocation2Selected} /><br/>



              <button className="Polaris-Button Polaris-Button--primary" onClick={e => {
                e.preventDefault();
                orderItem({ variables: { itemId: selectedItem,  locationId: selectedLocation, count: Number(selectedCount)} });
                window.location.reload();
              }}   type="submit">Order Item</button>

            <button className="Polaris-Button Polaris-Button--destructive" onClick={e => {
                e.preventDefault();
                removeOrderFromLoc({ variables: { itemId: selectedItem,  locationId: selectedLocation, count: Number(selectedCount)} });
                window.location.reload();
              }}   type="submit">Remove Order</button>

              <button className="Polaris-Button Polaris-Button--primary" onClick={e => {
                e.preventDefault();
                shipItemToLoc({ variables: { itemId: selectedItem,  locationId: selectedLocation, count: Number(selectedCount)} });
                window.location.reload();
              }}   type="submit">Ship Item to Location</button>

              <button className="Polaris-Button Polaris-Button--primary" onClick={e => {
                e.preventDefault();
                acceptItemAtLoc({ variables: { itemId: selectedItem,  locationId: selectedLocation, inventoryItemConditionName: selectedInventoryItemCondition, count: Number(selectedCount)} });
                window.location.reload();
              }}   type="submit">Accept Item at Location</button>

              <button className="Polaris-Button Polaris-Button--destructive" onClick={e => {
                e.preventDefault();
                markItemLost({ variables: { itemId: selectedItem,  locationId: selectedLocation, inventoryItemConditionName: selectedInventoryItemCondition , inventoryItemStateName: selectedInventoryItemState} });
                window.location.reload();
              }}   type="submit">Mark Lost</button>

              <button className="Polaris-Button Polaris-Button--primary" onClick={e => {
                e.preventDefault();
                transferItem({ variables: { itemId: selectedItem,  sourceLocationId: selectedLocation, destinationLocationId: selectedLocation2,inventoryItemConditionName: selectedInventoryItemCondition , count: Number(selectedCount)} });
                window.location.reload();
              }}   type="submit">Transfer Item</button>

          </form>
        </div>
    );
}

const showWhatButtonDoes = () => {
  console.log("ME PRESSED")
}

export default QueryPanel;
