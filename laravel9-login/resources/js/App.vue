<template>
  　Hello World
</template>

<script>
export default {
    data() {
        return {
            users: [],
        }
    },
    mounted() {
    axios.get("http://localhost:8000/sanctum/csrf-cookie").then((response) => (this.users = response.data));
    },
}
</script>