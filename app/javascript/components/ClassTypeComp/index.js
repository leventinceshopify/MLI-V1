// app/javascript/components/Library
import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import {ProductsQuery} from "./operations.graphql";


// import "@shopify/polaris@4.0.0/styles.min.css";
import '@shopify/polaris/styles.css';

// !!!!!!!!!!!!!!!
// Inside the component the .prop object contains the data object
// The data we need is contained in this.prop.data.allproducts property
class ClassTypeComp extends React.Component {
  render() {
    return <h1>Hello, {this.props.name}</h1>;
  }
}

export default ClassTypeComp;
