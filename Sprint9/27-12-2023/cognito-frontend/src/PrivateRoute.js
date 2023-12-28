// PrivateRoute.js
import React from 'react';
import { Route } from 'react-router-dom';
import { Redirect } from "react-router-dom";

const PrivateRoute = ({ element: Element, isAuthenticated, ...rest }) => {
  return (
    <Route
      {...rest}
      element={isAuthenticated ? <Element /> : <Redirect to="/signin" />}
    />
  );
};

export default PrivateRoute;
