<template>
  <div>
    <h1>
      assset API
    </h1>
    <h2>Users</h2>
    <ul>
      <li v-for="user in users" :key="user.id">
        {{ user.id }} - {{ user.name }}
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  async asyncData({ $axios }) {
    const users = await $axios.$get('/users.json')
    // OR
    // const users = await $axios.$get('http://localhost:3000/axios-assets-json')
    return { users }
  }
}
</script>
