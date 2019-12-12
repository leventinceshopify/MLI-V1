import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import { useQuery, useMutation } from '@apollo/react-hooks';

import {createVariantOfProduct, deleteVariant, updateVariant} from "./operations.graphql";

import ProductsList from '../ProductsList';
import VariantsList from '../VariantsList';

import {Button} from '@shopify/polaris';



import cs from './styles';
import '@shopify/polaris/styles.css';




function DefinitionsVariant() {

  const [variantName, setVariantName] = useState("");
  const [variantDescription, setVariantDescription] = useState("");
  const [variantPrice, setVariantPrice] = useState(0);
  const [selectedProduct, setSelectedProduct] = useState(null);
  const [selectedVariant, setSelectedVariant] = useState(null);


const [createVar] = useMutation(createVariantOfProduct);
const [deleteVar] = useMutation(deleteVariant);
const [updateVar] = useMutation(updateVariant);
// const [updateVar] = useMutation(updateVariant);


// const { loading, error, data } = useQuery(showProductInfo, { variables: { id: selectedProduct }});

  function onVariantNameEntered({ target }) {

    setVariantName(target.value);
    console.log(variantName);
  }
  function onVariantDescriptionEntered({ target }) {

    setVariantDescription(target.value);
    console.log(variantDescription);
  }
  function onVariantPriceEntered({ target }) {

    setVariantPrice(target.value);
    console.log(variantPrice);
  }

  function onProductSelected({ target }) {

    setSelectedProduct(target.value);
    console.log(selectedProduct);
  }

  function onVariantSelected({ target }) {

    setSelectedVariant(target.value);
    console.log(selectedPVariant);
  }


  return (

    <div >
<form style={{ width: '210px', borderRadius: '5px',backgroundColor: '#a9e2f9',padding: '5px'}}>
  <h1 style={{width: '200px', textAlign: 'center'}}><b>Create Variant</b></h1>
            <ProductsList onProductSelected={onProductSelected} /><br/>

          Name <br />
        <input name="variantName" type="text" style={{width: '200px', height: '25px'}}
          onChange={onVariantNameEntered}></input> <br/>
        Price <br />
        <input name="variantPrice" type="text" style={{width: '200px', height: '25px'}}
            onChange={onVariantPriceEntered}></input> <br/>
        Description<br />
      <textarea name="description" rows="5" style={{width: '200px'}}
        onChange={onVariantDescriptionEntered}> ></textarea><br/>

      <button className="Polaris-Button Polaris-Button--primary" onClick={e => {
          e.preventDefault();
          createVar({ variables: { name: variantName, productId:  parseInt(selectedProduct), description: variantDescription, price: parseFloat(variantPrice), size: "10", picture: " "} });
          window.location.reload();
        }}   type="submit" style={{width: '200px'}}>Create Variant</button>
      
      </form>
      <br/>
      <br/>
      <form style={{ width: '210px', borderRadius: '5px',backgroundColor: '#a9e2f9',padding: '5px'}}>
          <h1 style={{width: '200px', textAlign: 'center'}}><b>Delete Variant</b></h1>
          <VariantsList onVariantSelected={onVariantSelected} />
          <button className="Polaris-Button Polaris-Button--destructive" onClick={e => {
              e.preventDefault();
              deleteVar({ variables: { id: selectedVariant} });
              window.location.reload();
            }}   type="submit" style={{width: '200px'}}>Delete Variant</button>



    </form>
    <br/>
    <br/>

    <form style={{ width: '210px', borderRadius: '5px',backgroundColor: '#a9e2f9',padding: '5px'}}>
        <h1 style={{width: '200px', textAlign: 'center'}}><b>Update Variant</b></h1>
        <VariantsList onVariantSelected={onVariantSelected} />
        <ProductsList onProductSelected={onProductSelected} /><br/>
        Name <br />
        <input name="variantName" type="text" style={{width: '200px', height: '25px'}}
          onChange={onVariantNameEntered}></input> <br/>
        Price <br />
        <input name="variantPrice" type="text" style={{width: '200px', height: '25px'}}
            onChange={onVariantPriceEntered}></input> <br/>
        Description<br />
      <textarea name="description" rows="5" style={{width: '200px'}}
        onChange={onVariantDescriptionEntered}> ></textarea><br/>

      <button className="Polaris-Button Polaris-Button--primary" onClick={e => {
          e.preventDefault();
          updateVar({ variables: { id: parseInt(selectedVariant), name: variantName, productId:  parseInt(selectedProduct), description: variantDescription, price: parseFloat(variantPrice), size: "10", picture: " "} });
          window.location.reload();
        }}   type="submit" style={{width: '200px'}}>Update Variant</button>



</form>

    </div>



);

}


export default DefinitionsVariant;
// export default {VariantsList, ItemsofVariant};
