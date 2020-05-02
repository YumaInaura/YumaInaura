// https://axios.nuxtjs.org/setup.html#install

// https://ma-vericks.com/nuxt-axios/

// $ yarn add @nuxtjs/axios

// Edit nuxt.config.js
//
// modules: [
//   '@nuxtjs/axios',
// ],

<template>
  <h1>
    {{ response }}
  </h1>
</template>

<script>
export default {
  async asyncData({ $axios }) {
    const response = await $axios.$get('https://example.com')
    return { response }
  }
}
</script>
