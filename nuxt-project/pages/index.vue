<!-- https://develop365.gitlab.io/nuxtjs-2.8.X-doc/ja/api/configuration-loading/ -->

<template>
	<div>
		<span v-for="n in 10000">{{ n }} </span>
	</div>
</template>


<script>
import Vue from 'vue'

export default Vue.extend({
  mounted () {
    this.$nextTick(() => {
      this.$nuxt.$loading.start()
			setTimeout(() => this.$nuxt.$loading.finish(), 500)
		})
  },
	created() {
	},
	methods(){},
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

