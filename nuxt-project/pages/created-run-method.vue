<template>
  <div>
    <h1> Created run method </h1>
  <h2>{{ message }}</h2>
  </div>
</template>

<script>
export default {
  created () {
    this.setMessage()

    // ReferenceError: setMessage is not defined
    // setMessage()
  },
  methods: {
    setMessage () {
      this.message = "Hello"
    }
  }
}
</script>
