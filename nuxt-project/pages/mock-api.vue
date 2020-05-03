<template>
  <div class="container">
    <div>
      <logo />
      <h1 class="title">
        nuxt-project
      </h1>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {

  async asyncData ({ $axios, params }) {
    // const id = params.id
    const data = await $axios.$get(`/users/0`)
    return { data }
  }
}
</script>
