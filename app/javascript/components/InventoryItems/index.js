import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import {ShowInventoryQuery, ShowInventoryPerLocationQuery1, ShowInventoryPerLocationQuery2} from "./operations.graphql";
import cs from './styles';
import '@shopify/polaris/styles.css';

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
    return (<Query query={ShowInventoryQuery}>
      {
        ({data, loading}) => (<div>
          <button onClick={this.showWhatButtonDoes} className="Polaris-Button Polaris-Button--primary" > "Sonra yazdir"</button>

          <table >
            <tr>
              <th>Location-I</th>
              <th>Location-II</th>
            </tr>
            {





              loading || !data.showInventory
              ? "loading..."
              : data.showInventory.map(inventory_item => {

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
                  </table>
                </div>)
              }
            </Query>);
          }
        }



        export default ShowInventoryItems;
