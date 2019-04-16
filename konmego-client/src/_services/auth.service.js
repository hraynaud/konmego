import JWTDecode from 'jwt-decode';
import { apiService, eventService } from '../_services';

export const authService = {
    login,
    logout,
    currentUser,
};

const SESSION_AUTH_KEY = "jwt"
const SESSION_USER_KEY = "user"

function login(email, password) {
    return apiService.writeToApi({ email, password }, '/login')
        .then(handleLogin)
}

function logout() {
    // remove user from local storage to log user out
    localStorage.removeItem(SESSION_USER_KEY);
    sessionStorage.removeItem(SESSION_AUTH_KEY, '');
    eventService.$emit("logged-off");
}

function handleLogin(response) {
    if (response.jwt) {
        signIn(response.jwt);
    } else {
        return Promise.reject(response.error);
    }
}

function currentUser() {
    return JSON.parse(window.localStorage.getItem(SESSION_USER_KEY));
}

function signIn(jwt) {
    sessionStorage.setItem(SESSION_AUTH_KEY, jwt);

    //destructure using IIFE
    var user = (({ first, last }) => ({ first, last }))(JWTDecode(jwt));
    localStorage.setItem(SESSION_USER_KEY, JSON.stringify(user))
    eventService.$emit("logged-in", user);
}




