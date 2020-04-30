// https://www.sitepoint.com/vue-components-intro/

<template>
  <div>
    <h1>{{ msg }}</h1>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  props: {
    msg: {
      type: String,
      default: 'Ya!',
      required: false
    }
  }
}
</script>
