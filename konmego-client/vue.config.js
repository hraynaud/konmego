var HtmlWebpackPlugin = require('html-webpack-plugin');
var path = require('path');

module.exports = {

  configureWebpack: {
    plugins: [new HtmlWebpackPlugin({
      template: './src/_helpers/index.html',
    })],
    externals: {
      // global app config object
      config: JSON.stringify({
          apiUrl: 'http://localhost:3000'
      })
  }
  }
}
