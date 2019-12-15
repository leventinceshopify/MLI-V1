import React from 'react'; //DEFAULT OBJET IMPORT
import { render } from 'react-dom'; //NAMED OBJECT EXPORT
import Provider from '../components/Provider'; //DEFAULT OBJET IMPORT
// import Inventory from '../components/Inventory'; //DEFAULT OBJET IMPORT
// import ShowProduct from '../components/Inventory'; //DEFAULT OBJET IMPORT
// import ShowInventoryItems from '../components/InventoryItems'; //DEFAULT OBJET IMPORT
// import AdminInfo from "../components/AdminInfo";
import Main from "../components/Main"; //DEFAULT OBJET IMPORT
import { Page, TextStyle } from '@shopify/polaris';

  // <AdminInfo />

render(
  <Provider>
    <Main />
  </Provider>,
  document.querySelector('#root')
);
