
// https://nuxtjs.org/guide/vuex-store/

<template>
  <div>
    <div>
      <h1> {{ count }} </h1>
      <input type="button" @click="incrementCounter" value="Increment!">
    </div>
  </div>
</template>

<script>

export default {
  computed: {
    count () {
      return this.$store.state.increments.count
    }
  },
  methods: {
    incrementCounter (e) {
      this.$store.commit('increments/increment')
    }
  }
}
</script>

<style>
body {
  text-align: center;
}
</style>
