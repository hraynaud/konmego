import config from 'config';

export const apiService = {
    writeToApi,
};

function writeToApi(payload, path) {
    const requestOptions = {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
    };

    return fetch(`${config.apiUrl}/${path}`, requestOptions)
        .catch(function (error) {
            console.log("API Error:", error)
         })

}

function readFromApi(path, handler) {
    const requestOptions = {
        method: 'GET',
        headers: authHeader()
    };

    return fetch(`${config.apiUrl}/${path}`, requestOptions)
        .then(handler);
}