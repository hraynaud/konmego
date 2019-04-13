import config from 'config';
import { authHeader } from '../_helpers';
import { apiService } from '../_services';

export const authService = {
    login,
    logout,
    setToken
};

function setToken(jwt) {
    if (jwt) {
        sessionStorage.setItem('jwt', jwt);
    }
}

function login(email, password) {
    return apiService.writeToApi({ email, password }, '/login')
    .then(response => response.json())
    .then(handleResponse)
    .catch(error => {
        console.log("Auth Error", error)
    })
}

function logout() {
    // remove user from local storage to log user out
    localStorage.removeItem('user');
}

function handleResponse(response) {
    if (response.jwt) {
        setToken(response.jwt);
    }else{
        return Promise.reject(response.error);
    }

}

function setUser(user) {

    // login successful if there's a user in the response
    if (user) {
        // store user details and basic auth credentials in local storage 
        // to keep user logged in between page refreshes


        // user.authdata = window.btoa(email + ':' + password);
        // localStorage.setItem('user', JSON.stringify(user));
    }
    return user;
}