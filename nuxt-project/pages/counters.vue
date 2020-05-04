<template>
  <div>
    <h2>
      parentCount: {{ parentCount }}
    </h2>
    <input type="button" @click="incrementParentCounter" value="Increment Parent">
    <input type="button" @click="reset" value="reset Parent">
<!--
    <Counter :count="parentCount"/>
    <Counter :count="parentCount"/>
 -->
    <LocalCounter :count="parentCount"/>
    <LocalCounter :count="parentCount"/>
  </div>
</template>

<script>
import Counter from '~/components/Counter.vue'
import LocalCounter from '~/components/LocalCounter.vue'

export default {
  data () {
    return {
      parentCount: 1
    }
  },
  components: {
    Counter,
    LocalCounter
  },
  methods: {
    incrementParentCounter (e) {
      this.parentCount += 1
    },
    reset (e) {
      this.parentCount = 1
    },
  }
}
</script>
