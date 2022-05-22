var HtmlWebpackPlugin = require('html-webpack-plugin');
var path = require('path');

module.exports = {
  configureWebpack: {
    entry: path.resolve('./src/main.js'),
    plugins: [new HtmlWebpackPlugin({
      template: './src/_helpers/index.html',
    })],
    externals: {
      // global app config object
      config: JSON.stringify({
        apiUrl: process.env.NODE_ENV === 'development' ? 'http://localhost:3000' : ''
      })
    }
  },
  devServer: {
        port: 8081
    }
}
