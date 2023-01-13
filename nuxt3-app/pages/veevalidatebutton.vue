<template>
  <div>
    <input v-model="emailValue" type="text" />

    <button @click="submit">Submit</button>
    <p v-if="errorMessageEmail">{{ errorMessageEmail }}</p>
  </div>
</template>

<script setup>
import { useField } from 'vee-validate';

const { meta: emailValidateMeta, value: emailValue, errorMessage: errorMessageEmail } = useField("email", "required|email");

function submit(event) {
  console.log("validate check");

  if (!emailValidateMeta.valid) { return; }

  console.log(emailValue.value)
  console.log("submit");
}
</script>