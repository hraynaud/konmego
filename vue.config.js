var HtmlWebpackPlugin = require('html-webpack-plugin');
var path = require('path');

module.exports = {
  outputDir: path.resolve('../public'),
  configureWebpack: {
    entry: path.resolve('./konmego-client/src/main.js'),
    plugins: [new HtmlWebpackPlugin({
      template: './konmego-client/src/_helpers/index.html',
    })],
    externals: {
      // global app config object
      config: JSON.stringify({
        apiUrl: 'http://localhost:3000'
      })
    }
  }
}
