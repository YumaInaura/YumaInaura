<!-- https://teratail.com/questions/k9a3uom29j319c -->

<template>
  <div>
    <LikeNumber :numbering="0" @reset="reset"></LikeNumber>
    <LikeNumber :numbering="1" @reset="reset"></LikeNumber>
    <button @click="reset">Parent reset</button>
    <div>
      number
      {{ numbers[0] + numbers[1] }}
    </div>
  </div>
</template>

<script>
import LikeNumber from '../components/LikeNumber.vue'

export default {
  data(){
    return{
      numbers: [0,0],
      number1: 0,
      number2: 0,
    }
  },
  methods:{
    reset(){
      this.numbers = [0, 0]
    }
  },
  components:{
    LikeNumber
  }
}
</script>