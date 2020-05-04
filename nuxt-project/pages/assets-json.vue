<template>
  <div>
    <h1>
      assset API
    </h1>
    <a href="~/assets/example.json">A</a>
    <h2>Users</h2>
    <div>
      {{ users }}
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  // async asyncData ({ $axios }) {
  //   const users = await $axios.$get(`/_nuxt/assets/example.json`)
  //   return { user, users }
  // }
}
</script>
