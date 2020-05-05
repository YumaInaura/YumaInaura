<template>
  <div>
    <h1> v model selected </h1>
    <select v-model="selected" multiple>
      <option>AAAAA</option>
      <option>BBBBB</option>
      <option>CCCCC</option>
    </select>
    <br>
    <span>Selected: {{ selected }}</span>
  </div>
</template>

<script>
export default {
  data () {
    return {
      selected: ["BBBBB"]
    }
  },
}
</script>

<style>
body {
  padding: 1em;
}
</style>
