/* eslint-disable */
import mockServer from 'axios-mock-server'
import mockUsers from './users/_users'
import mockUser from './users/_userId'

export default (client) => mockServer([
  {
    path: '/users/',
    methods: mockUsers
  },
  {
    path: '/users/_userId',
    methods: mockUser
  }
], client, '')
