const users = [
  { id: 0, name: 'other-foo' },
  { id: 1, name: 'other-bar' }
]

export default {
  get() {
    return [200, users]
  }
}
