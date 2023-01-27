<!-- https://teratail.com/questions/k9a3uom29j319c -->

<template>
  <div>
    <div>
      Total Count
      {{
        numbers.reduce(function (sum, element) {
          return sum + element;
        }, 0)
      }}
    </div>
    <button @click="reset">Reset</button>

    <div v-for="item in items" v-bind:key="item">
      <CountupChild :numbering="item"></CountupChild>
    </div>
  </div>
</template>

<script>
import CountupChild from '../components/CountupChild.vue'

const countupLoop = 3;

export default {
  data() {
    return {
      numbers: [...Array(countupLoop)].map((_, i) => 0),
      items: [...Array(countupLoop)].map((_, i) => i)
    }
  },
  methods: {
    reset() {
      this.numbers = [...Array(countupLoop)].map((_, i) => 0)
    }
  },
  components: {
    CountupChild
  }
}
</script>