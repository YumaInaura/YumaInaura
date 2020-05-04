// https://vuejs.org/v2/guide/components-props.html
// https://vuejs.org/v2/guide/components-props.html#One-Way-Data-Flow

// mutating a prop directly since the value will be overwritten whenever the parent component re-renders. Instead, use a data or computed property based on the prop's value. Prop being mutated: "count"


<template>
  <div>
    <h2>
      Count: {{ localCount }}
    </h2>
    <input type="button" @click="incrementCounter" value="Increment!">
  </div>
</template>

<script>
export default {
  props: {
    count: {
      type: Number
    }
  },
  data: function () {
    return {
      localCount: this.count
    }
  },
  methods: {
    incrementCounter (e) {
      this.localCount = this.localCount + 1
    }
  }
}
</script>
