import React, { useState } from "react";
import { CognitoUser } from "amazon-cognito-identity-js";
import "./ForgotPasswordForm.css"; 
import appConfig from "./config";
import { CognitoUserPool } from "amazon-cognito-identity-js";
import { useHistory} from "react-router-dom";

function ForgotPasswordForm(props) {
  const [username, setUsername] = useState("");
  const [verificationCode, setVerificationCode] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [showContinuationForm, setShowContinuationForm] = useState(false);
  const history = useHistory();

  const handleUsernameChange = (e) => {
    setUsername(e.target.value);
  };

  const handleNewPasswordChange = (e) => {
    setNewPassword(e.target.value);
  };

  const handleVerificationCodeChange = (e) => {
    setVerificationCode(e.target.value);
  };

  const handlePasswordForgotten = (e) => {
    e.preventDefault();
    const userPool = new CognitoUserPool({
      UserPoolId: appConfig.UserPoolId,
      ClientId: appConfig.ClientId,
    });
    const trimmedUsername = username.trim();

    const userData = {
      Username: trimmedUsername,
      Pool: userPool,
    };

    const cognitoUser = new CognitoUser(userData);
    cognitoUser.forgotPassword({
      onSuccess: () => {
        setShowContinuationForm(true);
      },
      onFailure: (err) => {
        alert(err);
      },
    });
  };

  const handleContinuationForm = (e) => {
    e.preventDefault();
    const userPool = new CognitoUserPool({
      UserPoolId: appConfig.UserPoolId,
      ClientId: appConfig.ClientId,
    });
    const trimmedUsername = username.trim();
    const trimmedVerificationCode = verificationCode.trim();
    const trimmedNewPassword = newPassword.trim();

    const userData = {
      Username: trimmedUsername,
      Pool: userPool,
    };

    const cognitoUser = new CognitoUser(userData);
    cognitoUser.confirmPassword(trimmedVerificationCode, trimmedNewPassword, {
      onSuccess: () => {
        alert("Password changed successfully");
        history.push("/signin");

      },
      onFailure: (err) => {
        alert(err);
      },
    });
  };

  return (
    <div className="forgot-password-container">
      {!showContinuationForm ? (
        <div>
          <h1>Password forgotten?</h1>
          <form onSubmit={handlePasswordForgotten}>
            <input
              className="input-field"
              type="text"
              value={username}
              placeholder="Username"
              onChange={handleUsernameChange}
            />
            <br />
            <input className="submit-button" type="submit" value="Send Verification Code" />
          </form>
        </div>
      ) : (
        <div>
          <h1>Supply new password</h1>
          <form onSubmit={handleContinuationForm}>
            <input
              className="input-field"
              type="text"
              value={verificationCode}
              placeholder="Verification code"
              onChange={handleVerificationCodeChange}
            />
            <br />
            <input
              className="input-field"
              type="password"
              value={newPassword}
              placeholder="New password"
              onChange={handleNewPasswordChange}
            />
            <br />
            <input className="submit-button" type="submit" value="Set New Password" />
          </form>
        </div>
      )}
    </div>
  );
}

export default ForgotPasswordForm;
