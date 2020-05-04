<template>
  <div>
      {{ $route.query }}
  </div>
</template>

<script>
export default {
  created () {
    console.log(this.$route.query)
  },
}
</script>
