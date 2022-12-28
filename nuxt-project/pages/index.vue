<template>
	<Tutorial />
</template>

<script>
import Vue from 'vue'

export default Vue.extend({
  mounted () {
    this.$nextTick(() => {
      this.$nuxt.$loading.start()

      setTimeout(() => this.$nuxt.$loading.finish(), 2000)
    })
  },
	created() {

	},
	data: () => ({
		loading: false
	}),

	async asyncData({ $axios }) {
		const url = "https://example.com/";

		const response = await $axios.$get(url);
		console.log(response);
		return {
			posts: response
		};
	}
})
</script>

