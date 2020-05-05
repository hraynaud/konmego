function extractJsonData(data, key) {
  return data[key];
}

function setSortedData(jsonResponse, collectionName, sortField) {
  return sortData(
    extractJsonData(jsonResponse, collectionName).data,
    sortField
  );
}

function sortData(collection, key) {
  return collection.sort(function(a, b) {
    return a.attributes[key] > b.attributes[key] ? 1 : -1;
  });
}
export const jsonResponseHandler = {
  setSortedData,
};
