<template>
  <div>
    <input type="button" @click="resetParentCounter" value="resetParentCounter">
  </div>
</template>

<script>
export default {
  methods: {
    resetParentCounter (e) {
      this.$emit('reset-parent-counter')
    }
  }
}
</script>
