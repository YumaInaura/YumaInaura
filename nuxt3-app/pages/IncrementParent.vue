
<template>
  <div>
    <LikeHeader :totalNumber="number"></LikeHeader>
    <LikeNumber @total-increment="increment"></LikeNumber>
    <LikeNumber @total-increment="increment"></LikeNumber>
    <button @click="reset">reset</button>
  </div>
</template>
<script>
import LikeHeader from '../components/LikeHeader.vue'
import LikeNumber from '../components/LikeNumber.vue'

export default {
  data(){
    return{
      number:0
    }
  },
  methods:{
    increment(){
      this.number += 1
    },
    reset(){
      this.number = 0
    }
  },
  components:{
    LikeHeader
  }
}
</script>