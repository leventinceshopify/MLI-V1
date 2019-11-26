// app/javascript/components/Library
import React, {useState, setState, Component} from "react";
import {Query} from "react-apollo";
import {ProductsQuery} from "./operations.graphql";
import cs from "./styles";

// import "@shopify/polaris@4.0.0/styles.min.css";
import '@shopify/polaris/styles.css';

// !!!!!!!!!!!!!!!
// Inside the component the .prop object contains the data object
// The data we need is contained in this.prop.data.allproducts property
const state = {
  showVariant: true
}

const Inventory = () => {
  const [product, setProduct] = useState(null);

  console.log (this)
  return (
  //follwing code is important because when the page is loaded for the first data
  //there isn't data (graphql is empty) and until the data is fetced from DB it stays like that
  //if we don't perform following chech the .map cannot be executed on empty data and it gives an error.
  //.loading is a flag in prop.data which indicates the request is still pending.

  <Query query={ProductsQuery}>

    {
      ({ data, loading}) => (<div className={cs.inventory}>

        {

          loading || !data.allProducts
            ? "loading..."
            // : data.allProducts.map(({ name, id, description }) => (

            //allproducts is an array
            : data.allProducts.map(product => {
              return (<ul key={product.id}>
                <span>{product.id}  </span>
                <button onClick={showWhatButtonDoes} className="Polaris-Button Polaris-Button--primary">{product.name}</button>

              {Variants(product)}


              </ul>)
              // <button
              //   key={id}
              //   className={cs.plate}
              //   onClick={() => setProduct({ name, id, description })}
              // >
              //   <div className={cs.title}>{name}</div>
              //   <div>{description}</div>
              //
              //
              // </button>
              // ))}
            })}
  </div>)
}

</Query>);
};

const showWhatButtonDoes = () => {
  if (state.showVariant == true)
    {  //setState({showVariant: false})

     // setState(state => ({
     //      showVariant: false
     //    }));



      // state.showVariant = false
    }
  else {
    // state.showVariant = true
    // setState(state => ({
    //       showVariant: true
    //     }));
    // setState({showVariant: true})
  }

  console.log("id button is pressed");
  console.log(state.showVariant);
}

function Variants(product) {
if (state.showVariant) {  return (<div>
    <li>Name: {product.name}</li>
    <li>Overview: {product.description}</li>
    <li>Variants:
    </li>
    {
      product.variants.map(variant => {
        return (<ul key={variant.id}>
          <li>{variant.name}</li>
          <li>Items:
          </li>
          {
            variant.items.map(item => {
              return (<ul key={item.id}>
                <li>{item.name}</li>
              </ul>)
            })
          }
        </ul>)
      })
    }
  </div>)
}
else
return (<h1>YOK</h1>)

}


export default Inventory;
