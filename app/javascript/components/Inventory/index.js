// app/javascript/components/Library
import React, { useState } from "react";
import { Query } from "react-apollo";
import { ProductsQuery } from "./operations.graphql";
import cs from "./styles";

const Inventory = () => {
  const [product, setProduct] = useState(null);
  return (
    <Query query={ProductsQuery}>
      {({ data, loading }) => (
        <div className={cs.inventory}>
          {loading || !data.allProducts
            ? "loading..."
            : data.allProducts.map(({ name, id, description }) => (
                <button
                  key={id}
                  className={cs.plate}
                  onClick={() => setProduct({ name, id, description })}
                >
                  <div className={cs.title}>{name}</div>
                  <div>{description}</div>


                </button>
              ))}
        </div>
      )}
    </Query>
  );
};

export default Inventory;
