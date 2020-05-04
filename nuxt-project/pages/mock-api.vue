<template>
  <div  >
    <div>
      <h1>
        mock API
      </h1>
    </div>
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
  async asyncData ({ $axios }) {
    const user = await $axios.$get(`/users/1`)
    const users = await $axios.$get(`/users`)
    return { user, users }
  }
}
</script>
