<template>
  <div>
    <input type="text">
    <button @click="setFoo">Button</button>
    <button @click="setBar">Button</button>
    <p>{{ foo }}</p>
  </div>
</template>

<script>
export default {
  data: () => {
    return {
      foo: "",
    };
  },
  methods: {
    setFoo() {
      this.foo = "Foo"
    },
    setBar() {
      this.foo = "Bar"
    }
  },

};
</script>