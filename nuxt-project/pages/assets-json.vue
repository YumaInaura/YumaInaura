// https://log.pocka.io/posts/nuxt-asyncdata-static-file-code-splitting/

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
export default {
  asyncData({ params }) {
    const users = require(`~/assets/users.json`)
    return {
      users
    }
  }
}
</script>
