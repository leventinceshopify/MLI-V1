import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import { useQuery, useMutation } from '@apollo/react-hooks';

import {bindItemToVariant, deleteItemVariant} from "./operations.graphql";

import ItemsList from '../ItemsList';
import VariantsList from '../VariantsList';
import ItemVariantsList from '../ItemVariantsList';

import {Button} from '@shopify/polaris';



import cs from './styles';
import '@shopify/polaris/styles.css';



function DefinitionsItemVariantBind() {

  // const [itemName, setItemName] = useState("");
  const [selectedItemVariant, setSelectedItemVariant] = useState(null);
  const [selectedVariant, setSelectedVariant] = useState(null);
  const [selectedItem, setSelectedItem] = useState(null);

  const [createItemVaria] = useMutation(bindItemToVariant);
  const [deleteItemVaria] = useMutation(deleteItemVariant);
  // const [updateIte] = useMutation(updateItem);


// const { loading, error, data } = useQuery(showProductInfo, { variables: { id: selectedProduct }});



  function onItemSelected({ target }) {

    setSelectedItem(target.value);
    console.log(selectedItem);
  }

  function onVariantSelected({ target }) {

    setSelectedVariant(target.value);
    console.log(selectedVariant);
  }

  function onItemVariantSelected({ target }) {

    setSelectedItemVariant(target.value);
    console.log(selectedItemVariant);
  }


  return (

    <div >

      <form style={{ width: '210px', borderRadius: '5px',backgroundColor: '#a9e2f9',padding: '5px'}}>
        <h1 style={{width: '200px', textAlign: 'center'}}><b>Bind Item to Variant</b></h1>

          <VariantsList onVariantSelected={onVariantSelected} />
          <ItemsList onItemSelected={onItemSelected} />

      <button className="Polaris-Button Polaris-Button--primary" onClick={e => {
          e.preventDefault();
          createItemVaria({ variables: {itemId: parseInt(selectedItem) , variantId: parseInt(selectedVariant) } });
          window.location.reload();
        }}   type="submit" style={{width: '200px', height: '25px'}}>Bind Item-Variant</button>

    </form>
        <br/>
        <br/>

      <form style={{ width: '210px', borderRadius: '5px',backgroundColor: '#a9e2f9',padding: '5px'}}>
      <h1 style={{width: '200px', textAlign: 'center'}}><b>Break Bind</b></h1>

      <ItemVariantsList onItemVariantSelected={onItemVariantSelected} />

        <button className="Polaris-Button Polaris-Button--destructive" onClick={e => {
            e.preventDefault();
            deleteItemVaria({ variables: { id: selectedItemVariant} });
            window.location.reload();
          }}   type="submit" style={{width: '200px', height: '25px'}}>Delete Binding</button>

    </form>
    </div>



);

}






export default DefinitionsItemVariantBind;
// export default {VariantsList, ItemsofVariant};
