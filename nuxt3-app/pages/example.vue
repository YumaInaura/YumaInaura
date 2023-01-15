<script lang="ts" setup>
const onClick = () => {
  console.log("Button click");
};
</script>

<template>
  <div>
    <button @click="onClick()">Button</button>
  </div>
</template>