<template>
  <div>
    <h2>
      count: {{ count }}
    </h2>
    <h2>
      countDouble: {{ countDouble }}
    </h2>
    <input type="button" @click="incrementCounter" value="Increment!">
  </div>
</template>

<script>
export default {
  data () {
    return {
      count: 1
    }
  },
  computed: {
    countDouble () {
      return this.count * 2
    }
  },
  methods: {
    incrementCounter (e) {
      this.count = this.count + 1
    }
  }
}
</script>

// https://dev83.com/vue-computed-methods/
