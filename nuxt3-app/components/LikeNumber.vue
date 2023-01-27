<template>
  <div>
    <p>Good({{ $parent.numbers[this.numbering] }})</p>
    <button @click="increment">+1</button>
  </div>
</template>
<script>
export default {
  data() {
    return {
      number: 0,
    }
  },
  props: {
    numbering: {
      type: Number,
    }
  },
  methods: {
    increment() {
      this.number += 1
      this.$parent.numbers[this.numbering] = this.number;
    },
    // reset() {
    //   this.number = 0;
    // }
  }
}
</script>