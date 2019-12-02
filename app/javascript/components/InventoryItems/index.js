import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import {ShowInventoryQuery, ShowInventoryPerLocationQuery1, ShowInventoryPerLocationQuery2} from "./operations.graphql";
import cs from './styles';
import '@shopify/polaris/styles.css';

import './styles.module.css'

class ShowInventoryItems extends React.Component {

  // constructor(props) {
  //   super(props);
  //   this.state = {
  //     hideVariant: false,
  //     hideButtonText: "Hide Variants"
  //   };
  // }

  showWhatButtonDoes = () => {
    // if (this.state.hideVariant) {
    //   this.setState({hideVariant: false, hideButtonText: "Hide Variants"})
    // } else {
    //   this.setState({hideVariant: true, hideButtonText: "Show Variants"})
    // }
    // console.log("id button is pressed");
  }
  // <img src = {require(`${imgpath}`)} width="100" height="80"/>

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
      backgroundColor: '#f5f0f0'

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
      backgroundColor: '#d9d5d4'
      }






    return (<div><div ><Query query={ShowInventoryPerLocationQuery1}>
      {
        ({data, loading}) => (<div style={leftSide}>

          <button onClick={this.showWhatButtonDoes} className="Polaris-Button Polaris-Button--primary" > "Sonra yazdir"</button><br />
          <h1> LOCATION I</h1>
          {
            loading || !data.showInventoryPerLocation
            ? "loading..."
            : data.showInventoryPerLocation.map(inventory_item => {
              return (
                <ul key={inventory_item.id}>
                  <tr>
                    <td><label >{inventory_item.item.name}</label> - <label >{inventory_item.location.name}</label> - <label className={cs.available}>{inventory_item.inventoryItemState.name}</label>   </td>
                    <td><label className="Polaris-Label Polaris-Button--primary">{inventory_item.inventoryItemCondition.name}</label> -
                      <label className={cs.quantity}>{inventory_item.quantity}</label></td>
                    </tr>
                  </ul>)
                })
              }

            </div>)
          }
        </Query></div>

      <div ><Query query={ShowInventoryPerLocationQuery2}>
          {
            ({data, loading}) => (<div style={rightSide}>

              <button onClick={this.showWhatButtonDoes} className="Polaris-Button Polaris-Button--primary" > "Sonra yazdir"</button> <br />
              <h2> LOCATION II</h2>
              {
                loading || !data.showInventoryPerLocation
                ? "loading..."
                : data.showInventoryPerLocation.map(inventory_item => {
                  return (
                    <ul key={inventory_item.id}>
                      <tr>
                        <td><label >{inventory_item.item.name}</label> - <label >{inventory_item.location.name}</label> - <label className={cs.available}>{inventory_item.inventoryItemState.name}</label>   </td>
                        <td><label className="Polaris-Label Polaris-Button--primary">{inventory_item.inventoryItemCondition.name}</label> -
                          <label className={cs.quantity}>{inventory_item.quantity}</label></td>
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
