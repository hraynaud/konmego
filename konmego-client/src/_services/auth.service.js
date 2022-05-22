import JWTDecode from 'jwt-decode';
import { apiService } from '../_services';
import { SESSION_USER_KEY, SESSION_AUTH_KEY } from './constants';
import { store } from "../store";
const { localStorage, sessionStorage } = window

export const authService = {
    login,
    logout,
    currentUser
};

function login(email, password) {
    return apiService.post('/login', { email, password })
        .then(handleLogin)
}

function logout() {
    // remove user from local storage to log user out
    localStorage.removeItem(SESSION_USER_KEY);
    sessionStorage.removeItem(SESSION_AUTH_KEY, '');
    store.dispatch("logout");
}   

function currentUser() {
    return JSON.parse(localStorage.getItem(SESSION_USER_KEY));
}

function handleLogin(response) {
    if (response.headers.jwt) {
        signIn(response.headers.jwt);
    } else {
        return Promise.reject(response.error);
    }
}

function signIn(jwt) {
    sessionStorage.setItem(SESSION_AUTH_KEY, jwt);

    //pass the decoded jwt into IIFE then destructue and set user var.
  var user = (({ first, last }) => ({ first, last }))(JWTDecode(jwt));

  localStorage.setItem(SESSION_USER_KEY, JSON.stringify(user))
    store.dispatch("login")
}
