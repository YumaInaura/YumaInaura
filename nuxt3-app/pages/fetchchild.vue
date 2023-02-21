<template>
  <h2>FetchChild</h2>
  <div>{{ response }}</div>
</template>

<script setup lang="ts">
interface Props {
  response: Object
}

const props = withDefaults(defineProps<Props>(), {
  response: {},
});

watch(() => props.response, (first, second) => {
  console.log(
    "Watch props.selected function called with args:",
    first,
    second
  );
});

// // const responseJson = ref(props.responseJson)
// export default{
//   props: {
//     responseJson: {
//       type: Object,
//       required: true,
//       default: {}
//     }
//   }
// }
</script>