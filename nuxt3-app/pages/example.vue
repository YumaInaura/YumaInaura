<template>
    <button @click="goHome">GO GO</button>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import { useRouter } from 'vue-router'

export default defineComponent({
  setup() {
        const router = useRouter()

    const goHome = async () => {
        try {
            router.push("/");
        } catch (error) {
            console.log("[signinError]", error);
            alert(`NG:${error}`);
        }
    };

    return {
      goHome,
    }
  },
})
</script>
