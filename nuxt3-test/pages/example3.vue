<script setup lang="ts">
function foo() {
  useFetch("https://jsonplaceholder.typicode.com/todos/");
}

function bar() {
  useFetch("https://jsonplaceholder.typicode.com/todos/");
}
foo();
foo();
foo();

bar();
bar();
bar();
</script>

<template></template>
