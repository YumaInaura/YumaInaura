<script setup lang="ts">
function foo() {
  useFetch("https://jsonplaceholder.typicode.com/todos/", {
    key: (Math.random() * 1000).toString(),
  });
}

function bar() {
  useFetch("https://jsonplaceholder.typicode.com/todos/", {
    key: (Math.random() * 1000).toString(),
  });
}
foo();
foo();
foo();

bar();
bar();
bar();
</script>

<template></template>
