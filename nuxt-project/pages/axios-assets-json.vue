// https://teratail.com/questions/243271

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
  asyncData() {
    // Not work
    const users = axios.get('/assets/users.json')
    return {
      users
    }
  }
}
</script>
