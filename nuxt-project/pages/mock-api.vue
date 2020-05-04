<template>
  <div  >
    <div>
      <h1>
        mock API
      </h1>
    </div>
    <h2>API Response</h2>
    <div>
      {{ data }}
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  async asyncData ({ $axios }) {
    const data = await $axios.$get(`/users/1`)
    return { data }
  }
}
</script>
