<!-- https://vee-validate.logaretm.com/v4/guide/composition-api/validation/ -->

<template>
  <form @submit="submit">
    <input v-model="emailValue" type="text" />

    <button>Submit</button>
    <p v-if="errorMessageEmail">{{ errorMessageEmail }}</p>
</form>
</template>

<script setup>
import { useField } from 'vee-validate';

const { meta: emailValidateMeta, value: emailValue, errorMessage: errorMessageEmail } = useField("email", "required|email");

function submit(event) {
  event.preventDefault();

  console.log("validate check");

  if(!emailValidateMeta.valid) { return; }

  console.log("submit");
}
</script>