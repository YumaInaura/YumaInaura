<template>
  <ul>
    <li v-for="item in items">
      {{ item.id }} {{ item.title }}
    </li>
  </ul>
  <button @click="countUp">Count</button>
</template>

<script setup lang="ts">
let items = ref();

const countUp = async (): Promise<any> => {
  const items = await useFetch('https://jsonplaceholder.typicode.com/todos/')
  console.log(items)
  return items;
};
</script>

