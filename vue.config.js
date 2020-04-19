var HtmlWebpackPlugin = require('html-webpack-plugin');
var path = require('path');

module.exports = {
  configureWebpack: {
    entry: path.resolve('./konmego-client/src/main.js'),
    plugins: [new HtmlWebpackPlugin({
      template: './konmego-client/src/_helpers/index.html',
    })],
    externals: {
      // global app config object
      config: JSON.stringify({
        apiUrl: process.env.NODE_ENV === 'development' ? process.env.VUE_APP_SERVER_ENDPOINT : ''
      })
    }
  }
}
