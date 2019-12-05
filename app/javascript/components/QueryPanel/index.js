import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import { useQuery, useMutation } from '@apollo/react-hooks';

import {sellVariantFromLocation} from "./operations.graphql";

import ItemsOfVariant from '../ItemsOfVariant';
import VariantsList from '../VariantsList'
import LocationsList from '../LocationsList'


import cs from './styles';
import '@shopify/polaris/styles.css';


function QueryPanel() {

  const [selectedVariant, setSelectedVariant] = useState(null);
  const [selectedLocation, setSelectedLocation] = useState(null);
  const [selectedItem, setSelectedItem] = useState(null);
  const [sellVariant] = useMutation(sellVariantFromLocation);


    function onVariantSelected({ target }) {

      setSelectedVariant(target.value);
      console.log(selectedVariant);
    }

    function onLocationSelected({ target }) {

      setSelectedLocation(target.value);
      console.log(selectedLocation);
    }

    // function sellVariant({ target }) {
    //
    //   setSelectedVariant(target.value);
    //   console.log(selectedVariant);
    // }
    return (

        <div >
          <VariantsList onVariantSelected={onVariantSelected} />   <LocationsList onLocationSelected={onLocationSelected} />
          {selectedVariant && <ItemsOfVariant id={selectedVariant} />}

          <form onSubmit={e => {
            e.preventDefault();
            sellVariant({ variables: { variantId: selectedVariant,  locationId: selectedLocation, inventoryItemConditionName: "Normal"} });
            window.location.reload();
          }}>
            <input
               name="variantId"

               value={selectedVariant}

               style={{ width: "30px" }}
             />

             <input
                name="locationId"

                value={selectedLocation}

                style={{ width: "30px" }}
              />
           <button type="submit">Sell Variant</button>

       </form>
        </div>

    );

}

const showWhatButtonDoes = () => {

console.log("ME PRESSED")

}



export default QueryPanel;
// export default {VariantsList, ItemsofVariant};
