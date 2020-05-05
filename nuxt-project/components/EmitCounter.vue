
<template>
  <div>
    <h2>
      Count: {{ localCount }}
    </h2>
    <input type="button" @click="incrementCounter" value="incrementCounter">
    <input type="button" @click="resetParentCounter" value="resetParentCounter">
  </div>
</template>

<script>
export default {
  props: {
    count: {
      type: Number
    }
  },
  data: function () {
    return {
      localCount: this.count
    }
  },
  methods: {
    incrementCounter (e) {
      this.localCount = this.localCount + 1
    },
    resetParentCounter (e) {
      this.$emit('reset-parent-counter')
    }
  }
}
</script>
