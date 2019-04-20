import config from 'config';
import axios from 'axios';

const { sessionStorage } = window;
const baseConfig = {
  baseURL: `${config.apiUrl}`,
  headers: { 'Content-Type': 'application/json', 'Authorization': sessionStorage.getItem('jwt') },
};

function requestConfig(custConfig, path) {
  return { ...baseConfig, ...custConfig, url: path };
}

function writeToApi(path, payload) {
  return axios(requestConfig({ method: 'POST', data: JSON.stringify(payload) }, path))
    .catch(errHandler);
}

function readFromApi(path, params) {
  return axios(requestConfig({ method: 'GET' }, path))
    .catch(errHandler);
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
  writeToApi,
  readFromApi,
};
