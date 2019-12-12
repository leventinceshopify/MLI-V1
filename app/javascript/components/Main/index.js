import React from "react";
import NavBar from '../NavBar';
import About from '../About';
import ShowInventoryItems from '../InventoryItems';
import DefinitionsPanel from '../DefinitionsPanel';
import QueryPanel from '../QueryPanel';


import {BrowserRouter as Router, Switch, Route} from 'react-router-dom'

function Main  () {


  return (
    <Router>
      <div>
        <NavBar />

        <Switch>
          <Route path="/about"  component={About} />
          <Route path="/definitions"  component={DefinitionsPanel} />
          <Route path="/" exact component={ShowInventoryItems} />

        </Switch>
      </div>
    </Router>
  );
}




export default Main;
// export default {VariantsList, ItemsofVariant};
