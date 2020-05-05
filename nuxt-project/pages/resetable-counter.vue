<template>
  <div>
    <h2>
      Count: {{ parentCount }}
    </h2>
    <input type="button" @click="incrementParentCounter" value="Increment Parent">
    <ResetCounter @reset-parent-counter="reset"/>
  </div>
</template>

<script>
import ResetCounter from '~/components/ResetCounter.vue'

export default {
  data () {
    return {
      parentCount: 1
    }
  },
  components: {
    ResetCounter
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
