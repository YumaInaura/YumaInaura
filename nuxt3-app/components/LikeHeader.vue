<template>
  <div class="header">
      <p>Total Good</p>
      <p>{{ showNum }}</p>
  </div><!-- /.header -->
</template>
<script>
export default {
  props:{
      totalNumber:{
          type:Number,
          default:10
      }
  },
  computed:{
      showNum(){
          return(
              this.totalNumber
          )
      }

  }
}
</script>