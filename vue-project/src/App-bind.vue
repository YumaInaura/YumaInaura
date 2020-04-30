<template>
  <div id="app">
    <img alt="Vue logo" src="./assets/logo.png">
    <div>
      <input type="text" v-model="msg">
    </div>
    <h1>{{ msg }}</h1>
  </div>
</template>

<script>

export default {
  name: 'App',
  props: {
    msg: {
      type: String,
      default: 'Ya!',
    }
  }

  // data に書いても動く
  //
  // data () {
  //   return {
  //     msg: 'Ya!'
  //   }
  // }
}
</script>


<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
