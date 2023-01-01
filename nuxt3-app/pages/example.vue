<!-- https://zenn.dev/coedo/articles/86bc31acb4ea47 -->

<script lang="ts">
export default defineComponent({
  async setup() {
    const { data: items } = await useFetch('https://jsonplaceholder.typicode.com/todos/')
    return {
      items
    }
  },
})
</script>

<!--
<script setup lang="ts">
    const data = await fetch('https://jsonplaceholder.typicode.com/todos/')
    const { data: items } = await data.json()
    console.log(items)
</script> -->

<template>
  <ul>
    <li v-for="item in items">
      {{ item.id }} {{ item.title }}
    </li>
  </ul>
</template>
