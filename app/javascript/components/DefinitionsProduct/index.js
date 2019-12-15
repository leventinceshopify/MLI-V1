import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import { useQuery, useMutation } from '@apollo/react-hooks';

import {createProduct, deleteProduct, updateProduct, showProductInfo} from "./operations.graphql";

import ProductsList from '../ProductsList';

import {Button} from '@shopify/polaris';

import cs from './styles';
import '@shopify/polaris/styles.css';

function DefinitionsProduct() {

  const [productName, setProductName] = useState("");
  const [productDescription, setProductDescription] = useState("");
  const [selectedProduct, setSelectedProduct] = useState(null);

  const [createProd] = useMutation(createProduct);
  const [deleteProd] = useMutation(deleteProduct);
  const [updateProd] = useMutation(updateProduct);


  function onProductNameEntered({ target }) {

    setProductName(target.value);
    console.log(productName);
  }
  function onProductDescriptionEntered({ target }) {

    setProductDescription(target.value);
    console.log(productDescription);
  }

  function onProductSelected({ target }) {

    setSelectedProduct(target.value);
    console.log(selectedProduct);
  }


  return (

    <div  >

        <form style={{ width: '210px', borderRadius: '5px',backgroundColor: '#a9f2f9',padding: '5px'}}>
          <h1 style={{width: '200px', textAlign: 'center'}}><b>Create Product</b></h1>
          Name <br />
        <input name="productName" type="text" style={{width: '200px', height: '25px',}}
          onChange={onProductNameEntered}></input> <br/>
        Description<br />
      <textarea name="description" rows="5" style={{width: '200px'}}
        onChange={onProductDescriptionEntered}> ></textarea><br/>

      <button className="Polaris-Button Polaris-Button--primary" onClick={e => {
          e.preventDefault();
          createProd({ variables: { name: productName,  description: productDescription, picture: ""} });
          window.location.reload();
        }}   type="submit" style={{width: '200px'}}>Create Product</button>

        </form>
        <br/>
        <br/>
        <form style={{ width: '210px', borderRadius: '5px',backgroundColor: '#a9f2f9',padding: '5px'}}>
          <h1 style={{width: '200px', textAlign: 'center'}}><b>Delete Product</b></h1>
        <ProductsList onProductSelected={onProductSelected} />
        <button className="Polaris-Button Polaris-Button--destructive" onClick={e => {
            e.preventDefault();
            deleteProd({ variables: { id: selectedProduct} });
            window.location.reload();
          }}   type="submit" style={{width: '200px'}}>Delete Product</button>
          </form>
          <br/>
          <br/>
          <form style={{ width: '210px', borderRadius: '5px',backgroundColor: '#a9f2f9',padding: '5px'}}>
            <h1 style={{width: '200px', textAlign: 'center'}}><b>Update Product</b></h1>
          <ProductsList onProductSelected={onProductSelected} />
          Product Name: <br />
        <input name="productName" type="text" style={{width: '200px', height: '25px'}}
          onChange={onProductNameEntered}
          ></input> <br/>
        Product Description:<br />
      <textarea name="description" rows="5" style={{width: '200px'}}
        onChange={onProductDescriptionEntered}> ></textarea><br/>

      <button className="Polaris-Button Polaris-Button--primary" onClick={e => {
          e.preventDefault();
          updateProd({ variables: { id: parseInt(selectedProduct), name: productName,  description: productDescription, picture: ""} });
          window.location.reload();
        }}   type="submit"  style={{width: '200px'}} >Update Product</button>

    </form>
    </div>

);

}


export default DefinitionsProduct;
