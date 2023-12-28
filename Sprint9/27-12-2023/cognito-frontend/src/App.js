import { Config, CognitoIdentityCredentials } from "aws-sdk";
import { CognitoUserPool } from "amazon-cognito-identity-js";
import { Switch } from "react-router-dom";
import React, { useEffect, useState } from "react";
import SignInForm from './signin';
import appConfig from "./config";
import { BrowserRouter as Router } from 'react-router-dom';
import{Route} from 'react-router-dom'
import "./App.css"; // Import your custom CSS file for styling
import SignUpForm from "./signup";
import ForgotPasswordForm from "./forgotPassword"
import ConfirmRegistrationForm from "./confirmRegistration"
import HomePage from "./Home";
import PrivateRoute from "./PrivateRoute.js";

const App = () => {
  const [isSignedIn, setIsSignedIn] = useState(false);
  const [username, setUser] = useState("");
  const [usernameSignup, setUserSignup] = useState("");
  const [contact, setContact] = useState("");

  let onSignInSuccess = (user) => {
    setIsSignedIn(true);
    setUsername(user);
  };
  let onSignUpSuccess = (user, contact) => {
    setContact(contact);
    setUserSignup(user);
  };
  const setUsername = (newUsername) => {
    setUser(newUsername);
  };
  if (!appConfig.region || !appConfig.UserPoolId || !appConfig.ClientId) {
    alert(
      "Configuration is missing ...\nPlease edit the configuration file in ./src/config.js\nto configure your AWS User pool."
    );
  } else {
    Config.region = appConfig.region;
    Config.credentials = new CognitoIdentityCredentials({
      IdentityPoolId: appConfig.IdentityPoolId,
    });
  }

  useEffect(() => {
  }, [isSignedIn]);

  return (
    <Router>
      <Switch>

        <Route path="/signin">
          <SignInForm onSignInSuccess={onSignInSuccess} />
        </Route>
        <Route path="/signup">
          <SignUpForm onSignUpSuccess={onSignUpSuccess}/>
        </Route>
        <Route path="/forgotPassword">
          <ForgotPasswordForm />
        </Route>
        <Route path="/confirmRegistration">
          <ConfirmRegistrationForm usernameSignup={usernameSignup} contact={contact}/>
        </Route>
        <Route path="/home">
          {isSignedIn ? <HomePage username={username}/> : <SignInForm onSignInSuccess={onSignInSuccess} />}
        </Route>
        <Route path="/">
          {isSignedIn ? <SignInForm /> : <SignInForm onSignInSuccess={onSignInSuccess} />}
        </Route> 
      </Switch>
    </Router>
  );
};

export default App;
