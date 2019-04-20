import config from 'config';
import axios from 'axios';

export const apiService = {
  writeToApi,
  readFromApi,
};

// const baseConfig = {
//   baseURL: `${config.apiUrl}`,
//   headers: { 'Content-Type': 'application/json', 'Authorization': sessionStorage.getItem('jwt') },
// };

// function reqestConfig(custConfig){
//   return {...baseConfig, custConfig}
// }


function errHandler(error) {
  let msg;
  if (error.response) {
    msg = error.response.data.error;
  } else if (error.request) {
    msg = "Server not responding"
  } else {
    msg = "Unable to connect to API"
  }
  throw new Error(msg)
}

function writeToApi(path, payload) {
  const requestOptions = {
    method: 'POST',
    baseURL: `${config.apiUrl}`,
    headers: { 'Content-Type': 'application/json', 'Authorization': sessionStorage.getItem('jwt') },
    data: JSON.stringify(payload),
    url: path
  };
  return axios(requestOptions)
    .catch(function (error) {
      errHandler(error)
    })
}

function readFromApi(path, params) {
  const requestOptions = {
    method: 'GET',
    baseURL: `${config.apiUrl}`,
    headers: { 'Content-Type': 'application/json', 'Authorization': sessionStorage.getItem('jwt') },
    url: path,
  };

  return axios(requestOptions)
    .catch(function (error) {
      errHandler(error)
    })
}