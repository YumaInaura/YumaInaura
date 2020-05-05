
// https://nuxtjs.org/guide/vuex-store/

// store/increments.js

<template>
  <div>
    <div>
      <stateCounter/>
      <stateCounter/>
      <stateCounter/>
    </div>
  </div>
</template>

<script>

import StateCounter from '~/components/stateCounter.vue'

export default {
  components: {
    StateCounter
  }
}
</script>
