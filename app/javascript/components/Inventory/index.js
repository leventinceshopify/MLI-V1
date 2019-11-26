// app/javascript/components/Library
import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import {ProductsQuery} from "./operations.graphql";
import cs from "./styles";
import '@shopify/polaris/styles.css';

class ShowProduct extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      hideVariant: false,
      hideButtonText: "Hide Variants"
    };
  }

  showWhatButtonDoes = () => {
    if (this.state.hideVariant) {
      this.setState({hideVariant: false, hideButtonText: "Hide Variants"})
    } else {
      this.setState({hideVariant: true, hideButtonText: "Show Variants"})
    }
    console.log("id button is pressed");
  }
  // <img src = {require(`${imgpath}`)} width="100" height="80"/>

  render() {
    return (<Query query={ProductsQuery}>
      {
        ({data, loading}) => (<div className={cs.inventory}>
          <button onClick={this.showWhatButtonDoes} className="Polaris-Button Polaris-Button--primary">{this.state.hideButtonText}</button>
          {
            loading || !data.allProducts
            ? "loading..."
            : data.allProducts.map(product => {
              const imgpath = "./images/" + product.picture
              return (<ul key={product.id}>
                <span>
                  <img src = {require('./images/CanonEOS6DMarkIIDSLRCameraBody.jpg')} width="100" height="80"/>
                </span>
                <label className="Polaris-Label Polaris-Button--primary">{product.name}</label>
                {
                  this.state.hideVariant
                  ? ""
                  : <Variants product={product}/>
              }
            </ul>)
          })
        }
      </div>)
    }
  </Query>);
}
}

class Variants extends React.Component {
  render() {
    return (<div>
      <li><b>Overview:</b> {this.props.product.description}</li>
      <li><b>Variants:</b>
      </li>
      {
        this.props.product.variants.map(variant => {
          return (<ul key={variant.id}>
            <li><b>{variant.name}</b></li>
            <b>Items:
            </b>
            <Items variant={variant}/>

          </ul>)
        })
      }
    </div>)

  }
}

function Items(props) {
  // console.log(props.variant.name)
  if (1) {
    return (<div>

      {
        props.variant.items.map(item => {
          return (<ul key={item.id}>
            <li>{item.name}</li>
          </ul>)
        })
      }
    </div>)
  } else
  return (<h1>YOK</h1>)

}

export default ShowProduct;
