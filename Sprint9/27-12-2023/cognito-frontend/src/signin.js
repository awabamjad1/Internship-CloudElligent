import React, { useState } from "react";
import { CognitoUser, AuthenticationDetails } from "amazon-cognito-identity-js";
import { CognitoUserPool } from "amazon-cognito-identity-js";
import appConfig from "./config";
import { useHistory, Link } from "react-router-dom";
import "./Signin.css";

function Signin({ onSignInSuccess } ) {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const history = useHistory();

  const handleSignin = (e) => {
    e.preventDefault();

    const authenticationData = {
      Username: username,
      Password: password,
    };

    const authenticationDetails = new AuthenticationDetails(authenticationData);
    const userPool = new CognitoUserPool({
      UserPoolId: appConfig.UserPoolId,
      ClientId: appConfig.ClientId,
    });
    const userData = {
      Username: username,
      Pool: userPool,
    };

    const cognitoUser = new CognitoUser(userData);

    cognitoUser.authenticateUser(authenticationDetails, {
      onSuccess: (session) => {
        onSignInSuccess(username);
        history.push("/home");
      },
      onFailure: (err) => {
        alert(err);
        history.push("/signin");
      },
    });
  };

  return (
    <div className="container">
      <h2>CognitoApp</h2>
      <h1>Sign In</h1>
      <form onSubmit={handleSignin}>
        <input
          type="text"
          placeholder="Username"
          value={username}
          onChange={(e) => setUsername(e.target.value)}
        />
        <input
          type="password"
          placeholder="Password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
        <button type="submit">Sign In</button>
      </form>
      <p>
        <Link to="/forgotPassword">Forgot Password?</Link>
      </p>
      <p>
        Not signed up yet?{" "}
        <Link to="/signup">Sign up here</Link>
      </p>
    </div>
  );
}

export default Signin;
