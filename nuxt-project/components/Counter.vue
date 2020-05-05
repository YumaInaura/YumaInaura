<template>
  <div>
    <h2>
      Count: {{ count }}
    </h2>
    <input type="button" @click="incrementCounter" value="Increment!">
  </div>
</template>

<script>
export default {
  props: {
    count: {
      type: Number,
      default: 1
    },
  },
  methods: {
    incrementCounter (e) {
      this.count = this.count + 1
    }
  }
}
</script>
