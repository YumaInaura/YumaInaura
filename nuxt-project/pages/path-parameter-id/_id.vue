<template>
  <div>
    <h1>
      Path parameter id
    </h1>
    <h2>ID</h2>
    <div>
      {{ path_parameter_id }}
    </div>
    <h2>httpbin reponse</h2>
    <div>
      {{ response }}
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  async asyncData ({ $axios, params }) {
    const path_parameter_id = `${params.id}`
    const response = await $axios.$get(`https://httpbin.org/get?id=${path_parameter_id}`)

    return { path_parameter_id, response }
  }
}
</script>
