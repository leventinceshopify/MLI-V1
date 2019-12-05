import React, { Component, useCallback, useRef, useState } from "react";

import { graphql } from "react-apollo";
import {
  Card,
  Page,
  Layout,
  TextField,
  FormLayout,
  Button
} from "@shopify/polaris";

class Booking extends React.Component {

  render() {

    return (
      <Page title="Booking">
      <Layout>
      <Layout.AnnotatedSection>
      <Card sectioned>
      <FormLayout>
      <TextField
      label="First name"
      value="Levent"/>

      <TextField
      label="Last name"
      value="Ince"
      />
      <TextField
      type="tel"
      label="Phone Number"
      value="1123"
      />
      <TextField
      type="email"
      label="Email"
      value="kkkk@dd.com"
      />
      </FormLayout>
      <Button>Add Customer Info</Button>
      </Card>
      </Layout.AnnotatedSection>
      </Layout>
      </Page>

    );
  }


}

//export default Booking;
export default Booking;
