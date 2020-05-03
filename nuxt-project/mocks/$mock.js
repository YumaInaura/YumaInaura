/* eslint-disable */
import mockServer from 'axios-mock-server'
import mock0 from './users/_userId'

export default (client) => mockServer([
  {
    path: '/users/_userId',
    methods: mock0
  }
], client, '')
