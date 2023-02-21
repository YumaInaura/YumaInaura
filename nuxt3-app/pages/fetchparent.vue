
<template>
  <h1>Fetch – Response to Child</h1>
  <FetchChild  :response="response"/>
</template>

<script lang="ts" setup>
import FetchChild from "./fetchchild.vue"

const response = ref()
const responseJson = ref()

function fetchTodo() {
  fetch("https://jsonplaceholder.typicode.com/todos/1", {
    method: "GET",
  })
    .then((response) => {
      return response
    })
    .then((data) => {
      console.log(data)
      response.value = data
    })
}
fetchTodo()

</script>