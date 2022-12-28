<template>
  <Tutorial/>
</template>

<script>
import { console } from 'console';

	export default {
		async asyncData({ $axios }) {
			// 取得先のURL
			const url = "https://example.com/";
      // console.log("abc");
			// リクエスト（Get）
			const response = await $axios.$get(url);
			// 配列で返ってくるのでJSONにして返却
			return {
				posts: response
			};
		}
	};
</script>

