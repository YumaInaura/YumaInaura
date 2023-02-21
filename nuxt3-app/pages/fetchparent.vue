
<template>
  <h1>Todo</h1>
  <div>
    {{ todoItem.title }}
  </div>
</template>

<script setup lang="ts">
const todoItem = ref({})

async function selectTodo() {
  const data = await fetch(`https://jsonplaceholder.typicode.com/todos/1`)
  const json = await data.json()
  todoItem.value = json
}
selectTodo()

</script>