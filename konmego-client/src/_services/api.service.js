import config from 'config';
import axios from 'axios';

export const apiService = {
    writeToApi,
    readFromApi,
};

function writeToApi(path, payload) {
    const requestOptions = {
        method: 'POST',
        baseURL: `${config.apiUrl}`,
        headers: { 'Content-Type': 'application/json', 'Authorization': sessionStorage.getItem('jwt')},
        data: JSON.stringify(payload),
        url: path
    };

    const url = `${config.apiUrl}${path}`
       return axios(requestOptions)
        .catch(function (error) {
            let msg;
            if (error.response) {
                console.log(error.response.data);
                msg = error.response.data.error;
               
              } else if (error.request) {
                msg= "Server not responding"
                console.log(error);
              } else {
                mgs="Unable to connect to API"
              }
            throw new Error(msg)
        })

}

function readFromApi(path, params) {
    const requestOptions = {
        method: 'GET',
        baseURL: `${config.apiUrl}`,
        headers: { 'Content-Type': 'application/json', 'Authorization': sessionStorage.getItem('jwt')},
        url: path,
    };
    
    return axios(requestOptions)
    .catch(function (error) {
        let msg;
        if (error.response) {
            debugger
            msg = error.response.data.error;
          } else if (error.request) {
            msg= "Server not responding"
            console.log(error);
          } else {
            // Something happened in setting up the request that triggered an Error
            mgs="Unable to connect to API"
          }
        throw new Error(msg)
    })
}