<template>
  <div>
   <p>Good({{ number }})</p>
   <button @click="increment">+1</button>
  </div>
</template>
<script>
export default{
    export default{
  props:{
    number:{
      type:Number,
      default:0
    }
  },
  methods:{
      increment(){
          this.number += 1;
          this.$emit('total-increment', this.number)
      }
  }
}
</script>