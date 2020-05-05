<template>
  <div>
    <h2>
      {{ message }}
    </h2>
    <input v-model="message">
  </div>
</template>

<script>
export default {
  data () {
    return {
      message: "Please change message"
    }
  },
}
</script>
