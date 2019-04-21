import JWTDecode from 'jwt-decode';
import { apiService } from '../_services';

const { localStorage, sessionStorage } = window
export const SESSION_AUTH_KEY = "jwt"
export const SESSION_USER_KEY = "user"

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
}

function currentUser() {
    return JSON.parse(localStorage.getItem(SESSION_USER_KEY));
}

function handleLogin(response) {
    if (response.data.jwt) {
        signIn(response.data.jwt);
    } else {
        return Promise.reject(response.error);
    }
}

function signIn(jwt) {
    sessionStorage.setItem(SESSION_AUTH_KEY, jwt);

    //destructure using IIFE
    var user = (({ first, last }) => ({ first, last }))(JWTDecode(jwt));
    localStorage.setItem(SESSION_USER_KEY, JSON.stringify(user))
}
