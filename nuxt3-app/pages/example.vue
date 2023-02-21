<template>
  <h1>Todo</h1>
  <div>
    {{ todoItem.title }}
  </div>
</template>


<script setup lang="ts">

const todoItem = ref({})

async function selectTodo(selectedTodo) {
  console.log(selectedTodo);
  const data = await fetch(`https://jsonplaceholder.typicode.com/todos/${selectedTodo}`)
  const json = await data.json()
  this.todoItem = json
}
selectTodo()

</script>