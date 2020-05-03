<template>
  <div class="container">
    <div>
      <logo />
      <h1 class="title">
        mock API
      </h1>
    </div>
    <h2>API Response<h2>
    <div>
       {{ data }}
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {

  async asyncData ({ $axios, params }) {
    // const id = params.id
    const data = await $axios.$get(`/users/0`)
    // const data = await $axios.$get(`https://example.com`)
    return { data }
  }
}
</script>
