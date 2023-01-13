<!-- https://vee-validate.logaretm.com/v4/guide/components/validation -->
<!-- https://levelup.gitconnected.com/veevalidate-4-how-to-disable-the-submit-button-2c893c437021 -->

<template>
  <Form @submit="submit" :validation-schema="schema">
    <Field name="email" />
    <ErrorMessage name="email" />
    <!-- <Field name="password" type="password" />
    <ErrorMessage name="password" /> -->
    <button>Submit</button>
    {{  meta.dirty }}
  </Form>
</template>


<script setup lang="ts">
import * as yup from 'yup';

import { Form, Field, ErrorMessage } from 'vee-validate';
import { useField } from 'vee-validate';
import { useIsFormDirty, useIsFormValid } from "vee-validate";
import { useSubmitCount } from 'vee-validate';
const count = useSubmitCount();

const { value, meta } = useField('fieldName', undefined, {
  initialValue: '',
});


// const isDirty = useIsFormDirty("email");
  // const isValid = useIsFormValid("email");

  // const isValidNow = computed(() => {
  //   return isValid;
  // });

const submit = async () => {
  console.log('submit')
}
const schema = yup.object({
  email: yup.string().required().email()
});
</script>


<!--
<template>
  <input v-model="value" type="text" />
  <button :disabled="!meta.dirty">Submit</button>
</template>

<script setup>
import { useField } from 'vee-validate';
const { value, meta } = useField('fieldName', undefined, {
  initialValue: '',
});
</script>
 -->
