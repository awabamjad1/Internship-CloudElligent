import React, { useState } from "react";
import { CognitoUserAttribute } from "amazon-cognito-identity-js";
import appConfig from "./config";
import { CognitoUserPool } from "amazon-cognito-identity-js";
import { useHistory, Link } from "react-router-dom";
import "./SignUpForm.css";

function SignUpForm({ onSignUpSuccess } ) {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [phoneNumber, setPhoneNumber] = useState(""); // New state for phone number
  const history = useHistory();

  const handleUsernameChange = (e) => {
    setUsername(e.target.value);
  };

  const handlePasswordChange = (e) => {
    setPassword(e.target.value);
  };

  const handlePhoneNumberChange = (e) => {
    setPhoneNumber(e.target.value); // Update the phone number state
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const userPool = new CognitoUserPool({
      UserPoolId: appConfig.UserPoolId,
      ClientId: appConfig.ClientId,
    });
    const trimmedUsername = username.trim();
    const trimmedPassword = password.trim();
    const email = trimmedUsername;

    const attributeList = [
      new CognitoUserAttribute({ Name: "email", Value: email }),
      new CognitoUserAttribute({ Name: "given_name", Value: trimmedUsername }),
      new CognitoUserAttribute({ Name: "phone_number", Value: phoneNumber }),
    ];

    userPool.signUp(trimmedUsername, trimmedPassword, attributeList, null, (err, result) => {
      if (err) {
        alert(err + "\nPlease try again");
        return;
      }
      alert("Success");
      onSignUpSuccess(username,phoneNumber);
      history.push("/confirmRegistration");
    });
  };

  return (
    <div className="sign-up-container">
      <h2 className="app-name">CognitoApp</h2>
      <h1 className="sign-up-header">Sign up</h1>
      <form onSubmit={handleSubmit}>
        <input
          className="input-field"
          type="text"
          value={username}
          placeholder="Username"
          onChange={handleUsernameChange}
        />
        <br />
        <input
          className="input-field"
          type="password"
          value={password}
          placeholder="Password"
          onChange={handlePasswordChange}
        />
        <br />
        <input
          className="input-field"
          type="text"
          value={phoneNumber}
          placeholder="Phone Number" // Add phone number input
          onChange={handlePhoneNumberChange} // Handle phone number change
        />
        <br />
        <input className="submit-button" type="submit" value="Sign up" />
      </form>
      <p>
        Already have an account?{" "}
        <Link to="/signin">Sign in here</Link>
      </p>
    </div>
  );
}

export default SignUpForm;
