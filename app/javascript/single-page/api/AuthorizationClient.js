import axiosClient from './axiosClient.js'
import axios from 'axios';
import { useLocation } from 'react-router-dom'

function useQuery() {
  return new URLSearchParams(useLocation().search);
}

/**
 * Authenticate the user
 * @param {Object} user - The user trying to sign in
 * @param {string} user.email - User email.
 * @param {string} user.password - User password.
 */
function signIn(user) {
  // Need to use default axios lib because i don't want 
  //  interceptors to work for this request in particular
  //  method because the way rails returns 401 when e-mail
  //  and password don't match.
  return axios.post('/users/sign_in', { user: user }, { headers: { 'Accept': 'application/json' } });
}

/**
 * Create an user account
 * @param {Object} user
 * @param {File} user.avatar
 * @param {string} user.name
 * @param {string} user.email
 * @param {string} user.password
 * @param {string} user.password_confirmation
 */
function signUp(user) {
  let formData = new FormData();
  formData.append('user[avatar]', user.avatar || '');
  formData.append('user[name]', user.name);
  formData.append('user[email]', user.email);
  formData.append('user[password]', user.password);
  formData.append('user[password_confirmation]', user.password_confirmation);
  return axiosClient.post('/users', 
    formData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    });
}

/**
 * Request a password reset email
 * @param {Object} user
 * @param {string} user.email
 */
function requestPasswordReset(user) {
  return axiosClient.post('/users/password', { user: user });
}

/**
 * Reset user password
 * @param {Object} user
 * @param {string} user.password
 * @param {string} user.password_confirmation
 */
function resetPassword(user) {
  const query = new URLSearchParams(window.location.search);
  return axiosClient.put('/users/password', { user: { ...user, reset_password_token: query.get("reset_password_token")} });
}

const AuthorizationClient = {
  signIn, signUp, requestPasswordReset, resetPassword
}

export default AuthorizationClient;