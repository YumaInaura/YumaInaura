<script setup lang="ts">
import { computed } from "@vue/reactivity";

interface Props {
  value: string;
  label?: string;
  type?: "text" | "password" | "email" | "number";
  placeholder?: string;
  disabled?: boolean;
}

const props = defineProps<Props>();

const disabledClass = computed(() => {
  props.disabled ? "bg-gray-200" : "";
});
</script>
<template>
  <label>
    {{ label }}
    <input
      :class="disabledClass"
      :value="value"
      :type="type"
      :placeholder="placeholder"
      :disabled="disabled"
    />
  </label>
</template>