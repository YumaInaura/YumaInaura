
// https://github.com/m-mitsuhide/axios-mock-server

// file: 'index.js'
const axios = require('axios')
const mock = require('./mocks/$mock.js')

mock()

axios.get('https://example.com/users/1').then(({ data }) => {
  console.log(data)
})
