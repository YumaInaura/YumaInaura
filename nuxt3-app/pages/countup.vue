<template>
  <div>
    <p>{{ count }}</p>
  </div>
  <button @click="countUp">Count</button>
</template>

<script setup lang="ts">
let count = ref(0);
const countUp = (): number => {
  return count.value++;
};
</script>

