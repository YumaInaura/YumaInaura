<template>
  <AdminEventTitle
          :event_name="wata"
          :event_type="rara"
      />
</template>

<script setup lang="ts">
import AdminEventTitle from '@/pages/ex.vue'
// const event = ref<Event>()

// const getEvent = async () => {
//   const endpoint = `/api  /v1/{省略}/`
//   await axios.get(endpoint)
//       .then((response: any) => {

//           event.value = response.data
//   })
//   .catch((err) => {
//       console.log(err)
//   })
// }

// onMounted(async () => {  // ★eventはここで取得しています。
//   await getEvent()
// }

</script>