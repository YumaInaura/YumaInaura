<template>
  <FooChild
          :value="value"
      />
</template>

<script setup lang="ts">
import FooChild from '@/pages/child.vue'
const value = 1

</script>