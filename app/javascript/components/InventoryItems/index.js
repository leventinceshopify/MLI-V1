import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import {ShowInventoryQuery, ShowInventoryPerLocationQuery1, ShowInventoryPerLocationQuery2, variants} from "./operations.graphql";

// import VariantsList from '../VariantsList';
import QueryPanel from '../QueryPanel';


import cs from './styles';
import '@shopify/polaris/styles.css';

import './styles.module.css'

class ShowInventoryItems extends React.Component {


  showWhatButtonDoes = () => {

  }
  // <img src = {require(`${imgpath}`)} width="100" height="80"/>


  showState = (state) => {

    const available_state = {
      backgroundColor: '#80a619',
      textAlign: 'center',
      fontSize: '1.1em',
      fontWeight: 'bold',
      width: '100px',
      borderRadius: '5px'
    }

    const critical_level_state = {
      backgroundColor: '#f0f016',
      textAlign: 'center',
      fontSize: '1.1em',
      fontWeight: 'bold',
      width: '100px',
      borderRadius: '5px'
    }

    const out_of_stock_state = {
      backgroundColor: '#f20707',
      color: 'white',
      textAlign: 'center',
      fontSize: '1.1em',
      fontWeight: 'bold',
      width: '100px',
      borderRadius: '5px'
    }

    const committed_state = {
      backgroundColor: '#d1715c',
      textAlign: 'center',
      fontSize: '1.1em',
      fontWeight: 'bold',
      width: '100px',
      borderRadius: '5px'
    }

    const incoming_state = {
      backgroundColor: '#9ed15c',
      textAlign: 'center',
      fontSize: '1.1em',
      fontWeight: 'bold',
      width: '100px',
      borderRadius: '5px'
    }

    const ordered_state = {
      backgroundColor: '#e8e835',
      textAlign: 'center',
      fontSize: '1.1em',
      fontWeight: 'bold',
      width: '100px',
      borderRadius: '5px'

    }

    const lost_state = {
      backgroundColor: '#9e0505',
      color: 'white',
      textAlign: 'center',
      fontSize: '1.1em',
      fontWeight: 'bold',
      width: '100px',
      borderRadius: '5px'
    }

    const shipped_state = {
      backgroundColor: '#4e4e52',
      color: 'white',
      textAlign: 'center',
      fontSize: '1.1em',
      fontWeight: 'bold',
      width: '100px',
      borderRadius: '5px'
    }
    const normal_state = {
      backgroundColor: '#80a619',
      textAlign: 'center',
      fontSize: '1.1em',
      fontWeight: 'bold',
      width: '100px',
      borderRadius: '5px'
    }



    const refurbished_state = {
      backgroundColor: '#e8e835',
      textAlign: 'center',
      fontSize: '1.1em',
      fontWeight: 'bold',
      width: '100px',
      borderRadius: '5px'
    }

    const used_state = {
      backgroundColor: '#d1715c',
      textAlign: 'center',
      fontSize: '1.1em',
      fontWeight: 'bold',
      width: '100px',
      borderRadius: '5px'
    }

    const broken_state = {
      backgroundColor: '#9e0505',
      color: 'white',
      textAlign: 'center',
      fontSize: '1.1em',
      fontWeight: 'bold',
      width: '100px',
      borderRadius: '5px'
    }

    const not_sellable_state = {
      backgroundColor: '#4e4e52',
      color: 'white',
      textAlign: 'center',
      fontSize: '1.1em',
      fontWeight: 'bold',
      width: '100px',
      borderRadius: '5px'
    }

    const quantity_style = {

      fontSize: '1.2em',
      fontWeight: 'bold',
      width: '30px',
      textAlign: 'right',
      borderRadius: '5px'
    }

    const location_style = {
      fontSize: '0.9em',
      fontWeight: 'bold',
      width: '120px',
      textAlign: 'center',
      borderRadius: '5px'
    }

    const item_style = {
      fontSize: '0.9em',
      fontWeight: 'bold',
      width: '300px',
      textAlign: 'center',
      borderRadius: '5px'
    }


    switch(state) {
      case "Available":
      return available_state
      break;
      case "Critical_Level":
      return critical_level_state
      break;
      case "Out_of_Stock":
      return out_of_stock_state
      break;
      case "Committed":
      return committed_state
      break;
      case "Incoming":
      return incoming_state
      break;
      case "Shipped":
      return shipped_state
      break;
      case "Ordered":
      return ordered_state
      break;
      case "Lost":
      return lost_state
      break;
      case "Normal":
      return normal_state
      break;
      case "Refurbished":
      return refurbished_state
      break;
      case "Used":
      return used_state
      break;
      case "Broken":
      return broken_state
      break;
      case "Not_Sellable":
      return not_sellable_state
      break;
      case "Quantity":
      return quantity_style
      break;
      case "Location":
      return location_style
      break;
      case "Item":
      return item_style
      break;

      default:
      // code block
    }


  }

  render() {

    const leftSide = {
      height: '100%',
      width: '50%',
      position: 'fixed',
      zIndex: '1',
      top: '100',
      paddingTop: '20px',
      left: '0',
      overflowX: 'hidden',
      backgroundColor: '#f2f8fa'

    }

    const rightSide = {
      height: '100%',
      width: '50%',
      position: 'fixed',
      zIndex: '1',
      top: '100',
      paddingTop: '20px',
      right: '0',
      overflowX: 'hidden',
      backgroundColor: '#e6f4fa'
    }

// variables = {{id: 1}}


    return (<div>

      <QueryPanel />
      <div style={leftSide}><Query query={ShowInventoryPerLocationQuery1} >
      {
        ({data, loading}) => (<div >
          <h1 style={{width: '100%', textAlign: 'center'}}><b> LOCATION I</b></h1>

          {
            loading || !data.showInventoryPerLocation
            ? "loading..."
            : data.showInventoryPerLocation.map(inventory_item => {
              return (
                <ul key={inventory_item.id}>
                  <tr>
                    <td><label style={this.showState("Item")}>{inventory_item.item.name}</label> <label style={this.showState("Location")}>{inventory_item.location.name}</label><label style={this.showState(inventory_item.inventoryItemState.name)}>{inventory_item.inventoryItemState.name}</label></td>
                    <td><label style={this.showState(inventory_item.inventoryItemCondition.name)}>{inventory_item.inventoryItemCondition.name}</label>
                      <label style={this.showState("Quantity")}>{inventory_item.quantity}</label></td>
                    </tr>
                  </ul>)
                })
              }

            </div>)
          }
        </Query></div>

        <div  style={rightSide}><Query query={ShowInventoryPerLocationQuery2}>
          {
            ({data, loading}) => (<div>
              <h1 style={{width: '100%', textAlign: 'center'}}><b> LOCATION II</b></h1>
              {
                loading || !data.showInventoryPerLocation
                ? "loading..."
                : data.showInventoryPerLocation.map(inventory_item => {
                  return (
                    <ul key={inventory_item.id}>
                      <tr>
                        <td><label style={this.showState("Item")}>{inventory_item.item.name}</label> <label style={this.showState("Location")}>{inventory_item.location.name}</label><label style={this.showState(inventory_item.inventoryItemState.name)}>{inventory_item.inventoryItemState.name}</label>   </td>
                        <td><label style={this.showState(inventory_item.inventoryItemCondition.name)}>{inventory_item.inventoryItemCondition.name}</label>
                          <label style={this.showState("Quantity")}>{inventory_item.quantity}</label></td>
                        </tr>
                      </ul>)
                    })
                  }

                </div>)
              }
            </Query></div></div>


          );









        }
      }



      export default ShowInventoryItems;
