
<!-- https://smallit.co.jp/blog/829/ -->

<template>
  <div>
    <button @click="display = !display">
      表示切り替え
    </button>
    <transition name="opacity">
      <p style="margin-top:30px" v-if="display">表示箇所</p>
    </transition>
  </div>
</template>
<script>

export default {
  data(){
    return {
      display:true
    }
  }
}
</script>

<style scoped>
.opacity-enter{
  opacity: 0;
}
.opacity-enter-active{
  transition: opacity 1s;
}
.opacity-enter-to{
  opacity: 1;
}
.opacity-leave{
  opacity: 1;
}
.opacity-leave-active{
  transition: opacity 1s;
}
.opacity-leave-to{
  opacity: 0;
}
</style>