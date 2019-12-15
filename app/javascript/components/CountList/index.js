import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import { useQuery } from '@apollo/react-hooks';

import cs from './styles';
import '@shopify/polaris/styles.css';

function CountList  ({ onCountSelected }) {

  return (

    <select name="count" onChange={onCountSelected} style={{width: '200px', height: '25px'}}>
      <option>
        Select a Quantity
      </option>
      {[...Array(100).keys()].map(c => (
        <option key={c} value={Number(c)}>
          {c}
        </option>
      ))}
    </select>
  );
}

export default CountList;
