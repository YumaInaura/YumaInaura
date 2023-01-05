const path = require('path');

module.exports = function nuxtLog(moduleOptions) {
  const options = Object.assign({}, this.options.nuxtLog, moduleOptions);

  // Register plugin
  this.addPlugin({
    src: path.resolve(__dirname, 'plugin.js'),
    ssr: false,
    fileName: 'nuxtLog.js',
    options,
  });
};

module.exports.meta = require('./package.json');