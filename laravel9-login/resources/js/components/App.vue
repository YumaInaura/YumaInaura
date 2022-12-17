<template>
  <div>
    Hello vue component
  </div>
</template>

<script>
export default {
  props: ['text', 'num'],
  mounted() {
    alert(`component mounted! 'text' is ${this.text}, 'num' is ${this.num}`);
  },
}
</script>