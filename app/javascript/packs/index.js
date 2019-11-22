import React from 'react';
import { render } from 'react-dom';
import Provider from '../components/Provider';
import Inventory from '../components/Inventory';
import AdminInfo from "../components/AdminInfo";

render(
  <Provider>
    <AdminInfo />
    <Inventory />
  </Provider>,
  document.querySelector('#root')
);
