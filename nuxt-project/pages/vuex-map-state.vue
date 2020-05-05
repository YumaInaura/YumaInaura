// https://nuxtjs.org/guide/vuex-store

<template>
  <div>{{ count }}</div>
</template>

<script>
import { mapMutations } from 'vuex'

export default {
  computed: {
    count () {
      return this.$store.state.counters.count
    }
  },
  methods: {
    addTodo (e) {
      this.$store.commit('counters/count', e.target.value)
    }
  }
}
</script>

<style>
.done {
  text-decoration: line-through;
}
</style>