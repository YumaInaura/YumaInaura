<template>
  <div>
    {{value}}
  </div>
</template>

<script setup lang="ts">
const props = defineProps({
  value: [String, Number]
})
</script>
