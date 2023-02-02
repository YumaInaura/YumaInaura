<!-- https://teratail.com/questions/k9a3uom29j319c -->

<template>
  <div>
    <div>
      Total Count
      {{ totalCount }}
    </div>
    <button @click="reset">Reset</button>

    <div v-for="numbering in numberings" v-bind:key="numbering">
      <CountupChild :numbering="numbering"></CountupChild>
    </div>
  </div>
</template>

<script>
import CountupChild from '../components/CountupChild.vue'

const countupLoop = 3; // 子コンポーネントを作る数
const defaultNumbers = [...Array(countupLoop)].map((_, i) => 0); // [0,0,0] のような初期値

export default {
  data() {
    return {
      numbers: defaultNumbers,
      numberings: [...Array(countupLoop)].map((_, i) => i)
    }
  },
  // カウンターの値を全て合算
  computed: {
    totalCount: function () {
      return this.numbers.reduce(function (sum, element) {
          return sum + element;
        }, 0)
    }
  },
  methods: {
    reset() {
      console.log(defaultNumbers)
      this.numbers = [...Array(countupLoop)].map((_, i) => 0)
    }
  },
  components: {
    CountupChild
  }
}
</script>