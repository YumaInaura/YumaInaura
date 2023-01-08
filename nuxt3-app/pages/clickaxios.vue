<template>
  <ul>
    <li v-for="item in items">
      {{ item.id }} {{ item.title }}
    </li>
  </ul>
</template>

<script lang="ts">
export default defineComponent({
  async setup() {
    const { data: items } = {await useFetch('https://jsonplaceholder.typicode.com/todos/')}
    return {
      items
    }
  },
})
</script>
