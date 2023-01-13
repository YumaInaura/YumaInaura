<!-- https://vee-validate.logaretm.com/v4/guide/composition-api/validation/ -->

<template>
  <form @submit="submit">
    <p>Name <input v-model="nameValue" type="text" /></p>
    <p>Email<input v-model="emailValue" type="text" /></p>

    <button>Submit</button>
    <p v-if="errorMessageName">{{ errorMessageName }}</p>
    <p v-if="errorMessageEmail">{{ errorMessageEmail }}</p>
</form>
</template>

<script setup>
import { useField } from 'vee-validate';

const { meta: nameValidateMeta, value: nameValue, errorMessage: errorMessageName } = useField("name", "required");
const { meta: emailValidateMeta, value: emailValue, errorMessage: errorMessageEmail } = useField("email", "required|email");

function submit(event) {
  event.preventDefault();

  console.log("validate check");

  if(!nameValidateMeta.valid) {
    console.log("name is invalid")
    return;
  }
  if(!emailValidateMeta.valid) {
    console.log("email is invalid")
    return;
  }

  console.log("submit");
  console.log(nameValue.value)
  console.log(emailValue.value)
}
</script>