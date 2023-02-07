<template>
  <div>
    <p>Count ({{ $parent.numbers[this.numbering] }})</p>
    <button @click="increment">+1</button>
  </div>
</template>
<script>
export default {
  props: {
    numbering: {
      type: Number,
    }
  },
  methods: {
    increment() {
      this.$parent.numbers[this.numbering] += 1;
    },
  }
}
</script>