<template>
  <div>
    <h2>
      parentCount: {{ parentCount }}
    </h2>
    <input type="button" @click="incrementParentCounter" value="Increment Parent">
    <input type="button" @click="reset" value="reset Parent">
    <EmitCounter :count="parentCount" @reset-parent-counter="reset"/>
    <LocalCounter :count="parentCount"/>
  </div>
</template>

<script>
import Counter from '~/components/Counter.vue'
import LocalCounter from '~/components/LocalCounter.vue'
import EmitCounter from '~/components/EmitCounter.vue'

export default {
  data () {
    return {
      parentCount: 1
    }
  },
  components: {
    Counter,
    LocalCounter,
    EmitCounter
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
