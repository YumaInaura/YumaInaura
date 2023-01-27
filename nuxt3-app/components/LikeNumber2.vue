<template>
  <div>
    <p>Good({{ number }})</p>
    <button @click="increment">+1</button>
  </div>
</template>
<script>
export default {
  data(){
    return{
      number: 0,
    }
  },
  // props: {
  //   numberProp: {
  //     type: Number,
  //     default: 0
  //   }
  // },
  methods: {
    increment() {
      this.number += 1;
      this.$parent.number2 = this.number;
      this.$emit('incrementNumber1')
    }
  }
}
</script>