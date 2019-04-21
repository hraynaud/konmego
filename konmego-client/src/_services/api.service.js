import config from 'config';
import axios from 'axios';
import {SESSION_AUTH_KEY} from './auth.service';

const { sessionStorage } = window;
const baseConfig = {
  baseURL: `${config.apiUrl}`,
  headers: { 'Content-Type': 'application/json', 'Authorization': sessionStorage.getItem(SESSION_AUTH_KEY) },
};

function post(path, payload) {
    return execute('POST', path,  stringify(payload))
}

function get(path, params) {
    return execute('GET', path, {}, params)
}

// eslint-disable-next-line no-unused-vars
function put(path, payload, params) {
  return execute('PUT', path,stringify(payload), params)
}

//the word 'delete 'is a js operator
// eslint-disable-next-line no-unused-vars
function del(path, params) {
  return execute('DELETE', path,{}, params)
}
// eslint-disable-next-line no-unused-vars
function patch(path, payload,params) {
  return execute('PATCH', path, stringify(payload) , params)
}

function execute(method, path, data={}, params={}){
  return axios(requestConfig({ method: method, ...data, ...params }, path))
    .catch(errHandler);
}

function requestConfig(custConfig, path) {
  return { ...baseConfig, ...custConfig, url: path };
}

function stringify(payload){
  return {data: JSON.stringify(payload  )}
}

function errHandler(error) {
  let msg;
  if (error.response) {
    msg = error.response.data.error;
  } else if (error.request) {
    msg = "Server not responding";
  } else {
    msg = "Unable to connect to API";
  }
  throw new Error(msg);
}

export const apiService = {
  post,
  get,
};


