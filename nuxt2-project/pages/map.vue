<template>
  <ul>
    <li v-for="item in items">
      {{ item.id }} {{ item.title }}
    </li>
  </ul>
</template>

<script>

export default {
  data: () => {
    return {
      items: [],
    };
  },
  async mounted() {
    const data = await fetch('https://jsonplaceholder.typicode.com/todos/')
    const json = await data.json()
    this.items = json
  }
};
</script>