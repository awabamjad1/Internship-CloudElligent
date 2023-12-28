import React, { useState } from "react";
import { CognitoUser } from "amazon-cognito-identity-js";
import { CognitoUserPool } from "amazon-cognito-identity-js";
import appConfig from "./config";
import "./ConfirmRegistrationForm.css";
import { useHistory} from "react-router-dom";

function ConfirmRegistrationForm(props) {
  const {usernameSignup, contact} = props;
  const [username, setUsername] = useState(usernameSignup);
  const [verificationCode, setVerificationCode] = useState("");
  const userPool = new CognitoUserPool({
    UserPoolId: appConfig.UserPoolId,
    ClientId: appConfig.ClientId,
  });
  const history = useHistory();

  const handleUsernameChange = (e) => {
    setUsername(e.target.value);
  };

  const handleVerificationCodeChange = (e) => {
    setVerificationCode(e.target.value);
  };

  const handleSubmit = (e) => {
    e.preventDefault();

    var userData = {
      Username: username.trim(),
      Pool: userPool,
    };
    var cognitoUser = new CognitoUser(userData);
    cognitoUser.confirmRegistration(verificationCode.trim(), true, function (
      err,
      result
    ) {
      if (err) {
        alert(err);
        return;
      }
      try {
        // Create a JSON object with the image attribute
        const requestBody = {
          username: username,
          contact: contact,
        };
  
      } catch (error) {
        alert(error.message);
        // Handle the error (e.g., display an error message)
      }
      alert("Success");
      history.push("/signin");

    });
  };

  const handleResendCode = (e) => {
    e.preventDefault();

    var userData = {
      Username: username.trim(),
      Pool: userPool,
    };
    var cognitoUser = new CognitoUser(userData);
    cognitoUser.resendConfirmationCode(function (err, result) {
      if (err) {
        alert(err);
        return;
      }
      alert("call result: " + result);
    });
  };

  return (
    <div className="sign-up-container">
      <h2 className="app-name">CognitoApp</h2>
      <h1 className="sign-up-header">Confirm registration</h1>
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
          type="text"
          value={verificationCode}
          placeholder="Verification code"
          onChange={handleVerificationCodeChange}
        />
        <br />
        <input className="submit-button" type="submit" value="Confirm registration" />
      </form>
      <form onSubmit={handleResendCode}>
        <input className="submit-button" type="submit" value="Request new verification code" />
      </form>
    </div>
  );
}

export default ConfirmRegistrationForm;
