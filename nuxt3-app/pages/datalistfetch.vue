<template>
  <div class="main">
    <h1>Todo</h1>
    <div>
      <input v-model="text" list="item" @change="selectTodo(text)" />
      <datalist id="item">
        <div v-for="todo in todoList" :key="todo.value">
          <option :value="todo.value">{{ todo.name }}</option>
        </div>

      </datalist>
    </div>
    <h2>Todo</h2>
    {{ todoItem.title }}
  </div>
</template>
<script>

export default {
  data() {
    return {
      todoList: [{ name: "TODO1", value: 1 }, { name: "TODO2", value: 2 }, { name: "TODO3", value: 3 }],
      queryTodo: '',
      todoItem: {}
    }
  },

  methods: {
    async selectTodo(selectedTodo) {
      console.log(selectedTodo);
      const data = await fetch(`https://jsonplaceholder.typicode.com/todos/${selectedTodo}`)
      const json = await data.json()
      this.todoItem = json
    },
  },
}
</script>