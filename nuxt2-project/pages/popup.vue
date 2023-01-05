<!-- https://mebee.info/2020/02/12/post-6053/ -->

<template>
  <div class="container">
    <div>
      <Logo />
      <div>
      <button
        ref="button"
        class="toggle-button"
        @click="showPopup = !showPopup"
      >
        show
      </button>
      <div
        v-show="showPopup"
        v-closable="{
          exclude: ['button'],
          handler: 'onClose'
        }"
        class="popup-box"
      >
        ポップアップ
      </div>
      </div>
    </div>
  </div>
</template>

<script>
import Logo from '~/components/NuxtLogo.vue'

export default {
  name: 'Nuxttest',
  components: {
    Logo
  },
  data () {
    return {
      showPopup: false
    }
  },
  methods: {
    onClose () {
      this.showPopup = false
    }
  }
}
</script>
<style>
.container {
  margin: 0 auto;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
  font-size: 40px;
}
.toggle-button {
  background: #38b508;
  color: #FFF;
  border: 0;
  border-radius: 2px;
  padding: 10px;
  font-size: 14px;
  cursor: pointer;
  outline: none;
  transition: 0.2s all;
}
.toggle-button:hover {
  background: #38b508;
}
.popup-box {
  position: absolute;
  left: 50%;
  top: 50px;
  transform: translateX(-50%);
  background: #38b508;
  border-radius: 1px;
  box-shadow: 1px 1px 15px 0 rgba(0,0,0,0.2);
  padding: 40px;
  color: #FFF;
}
</style>