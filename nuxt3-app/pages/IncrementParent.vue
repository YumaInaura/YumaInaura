
<template>
  <div>
    <LikeNumber @total-increment="increment"></LikeNumber>
    <LikeNumber2 @total-increment="increment"></LikeNumber2>
    <button @click="reset">Parent reset</button>
    <div>
      number
      {{ number1 + number2 }}
    </div>
  </div>
</template>

<script>
import LikeNumber from '../components/LikeNumber.vue'
import LikeNumber2 from '../components/LikeNumber2.vue'

export default {
  data(){
    return{
      number1: 0,
      number2: 0,
    }
  },
  methods:{
    increment(){
      this.number += 1
    },
    incrementNumber1(){
      this.number1 += 1
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