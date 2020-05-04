/* eslint-disable */
import mockServer from 'axios-mock-server'
import mock0 from './users/_userId'
import mock1 from './users'

export default (client) => mockServer([
  {
    path: '/users/_userId',
    methods: mock0
  },
  {
    path: '/users',
    methods: mock1
  }
], client, '')
