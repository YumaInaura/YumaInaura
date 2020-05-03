/* eslint-disable */
module.exports = (client) => require('axios-mock-server')([
  {
    path: '/users/_userId',
    methods: require('./users/_userId')
  }
], client)