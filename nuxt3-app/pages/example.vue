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
    const items = []

    const getTodos = async () => {
      const data = await fetch('https://jsonplaceholder.typicode.com/todos/')
      const json = await data.json()
      this.items = json
    }
  },
})
</script>
