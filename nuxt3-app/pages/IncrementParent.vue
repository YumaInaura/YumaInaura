<!-- https://teratail.com/questions/k9a3uom29j319c -->

<template>
  <div>
    <div>
      Total Count
      {{ numbers[0] + numbers[1] }}
    </div>
    <button @click="reset">Reset</button>
    <CountupChild :numbering="0"></CountupChild>
    <CountupChild :numbering="1"></CountupChild>
  </div>
</template>

<script>
import CountupChild from '../components/CountupChild.vue'

export default {
  data(){
    return{
      numbers: [0,0],
    }
  },
  methods:{
    reset(){
      this.numbers = [0,0]
    }
  },
  components:{
    CountupChild
  }
}
</script>