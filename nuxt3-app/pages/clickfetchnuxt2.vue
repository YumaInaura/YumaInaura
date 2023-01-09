<template>
  <div>
    <div>
      <button @click="getTodos">getTodos</button>
    </div>
    <ul>
      <li v-for="item in items">
        {{ item.id }} {{ item.title }}
      </li>
    </ul>
  </div>
</template>

<script>

export default {
  data: () => {
    return {
      items: [],
    };
  },
  methods: {
    async getTodos() {
      const data = await fetch('https://jsonplaceholder.typicode.com/todos/')
      const json = await data.json()
      this.items = json
    }
  },
};
</script>