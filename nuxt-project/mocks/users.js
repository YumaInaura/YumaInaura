const users = [
  { id: 0, name: 'foo' },
  { id: 1, name: 'bar' }
]

export default {
  get() {
    return [200, users]
  }
}
