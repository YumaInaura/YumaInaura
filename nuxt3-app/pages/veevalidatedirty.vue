<!-- https://vee-validate.logaretm.com/v4/guide/components/validation -->

<template>
  <form @submit="submit">
    <input name="email" v-model="emailValue" type="text" />

    <button>Submit</button>
    <p v-if="errorMessageEmail">{{ errorMessageEmail }}</p>
    <p>isDirty {{  isDirty  }}</p>
    <p>isValid {{  isValid  }}</p>
</form>
</template>

<script setup>
import { useField, useIsFormDirty, useIsFieldValid } from 'vee-validate';

const { meta: emailValidateMeta, value: emailValue, errorMessage: errorMessageEmail } = useField("email", "required|email");
const isDirty = useIsFormDirty("email");
const isValid = useIsFieldValid("email");

function submit(event) {
  event.preventDefault();

  console.log("validate check");

  if(!emailValidateMeta.valid) { return; }

  console.log("submit");
}
</script>