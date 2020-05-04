<template>
  <div>
    <h1>
      mock API
    </h1>
    <h2>User</h2>
    <div>
      {{ user }}
    </div>
    <h2>Users</h2>
    <div>
      {{ users }}
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  async asyncData ({ $axios, id }) {
    const user = await $axios.$get(`/users/${id}`)
    const users = await $axios.$get(`/users`)
    return { user, users }
  }
}
</script>
