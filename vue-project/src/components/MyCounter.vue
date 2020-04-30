// https://www.sitepoint.com/vue-components-intro/


<template>
  <div>{{ count }}</div>
</template>

<script>
export default {
  name: 'my-counter',
  data() {
    return {
      count: 0
    }
  }
}
</script>

<style></style>