import React from 'react'; //DEFAULT OBJET IMPORT
import { render } from 'react-dom'; //NAMED OBJECT EXPORT
import Provider from '../components/Provider'; //DEFAULT OBJET IMPORT
// import Inventory from '../components/Inventory'; //DEFAULT OBJET IMPORT
import ShowProduct from '../components/Inventory'; //DEFAULT OBJET IMPORT
import AdminInfo from "../components/AdminInfo"; //DEFAULT OBJET IMPORT
import { Page, TextStyle } from '@shopify/polaris';

render(
  <Provider> //Wrapper

    <AdminInfo />
    <ShowProduct />

  </Provider>,
  document.querySelector('#root')
);
