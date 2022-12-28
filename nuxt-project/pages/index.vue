<template>
  <Tutorial/>
</template>

<script lang="ts">
		import Vue from 'vue'

		export default Vue.extend({
	    created() {
    },
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

