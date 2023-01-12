
<!-- https://debug-life.net/entry/4196 -->

<script lang="ts" setup>
import { useField } from "vee-validate";

const { value: username, errorMessage: usernameError } = useField(
  "username",
  "required|min:2", // バリデーションルールを文字列形式で指定
);
const { value: email, errorMessage: emailError } = useField(
  "email",
  "required|email", // バリデーションルールを文字列形式で指定
);

const submit = () => {
  console.log(username.value, email.value);
};
</script>

<template>
  <div class="form">
    <div class="field">
      <label for="username">username</label>
      <input type="text" v-model="username" name="username" />
      <small v-if="usernameError"
        ><span class="invalid">{{ usernameError }}</span></small
      >
    </div>
    <div class="field">
      <label for="email">email</label>
      <input
        type="text"
        v-model="email"
        name="email"
        placeholder="admin@example.com"
      />
      <small v-if="emailError"
        ><span class="invalid">{{ emailError }}</span></small
      >
    </div>
    <div class="field">
      <button type="button" @click="submit">登録</button>
    </div>
  </div>
</template>

<style lang="scss" scoped>
html {
  font-size: 14px;
}
.form {
  .field {
    padding: 0.5rem 0;
  }
  input {
    width: 15rem;
    display: block;
  }
  label {
    display: block;
    font-weight: bold;
  }

  .invalid {
    color: red;
  }
}
</style>