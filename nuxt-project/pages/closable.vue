<!-- https://www.npmjs.com/package/vue-closable -->

<template>
  <div id="app">
    <button ref="button" class="toggle-button" @click="showPopup = !showPopup">
      TOGGLE
    </button>
    <transition name="opacity">
      <div v-show="showPopup" v-closable="{
        exclude: ['button'],
        handler: 'onClose'
      }" class="popup-box">
        Test Popup Box
      </div>
    </transition>
  </div>
</template>

<script>
import Vue from 'vue'
import VueClosable from 'vue-closable'

Vue.use(VueClosable)

export default {
  data() {
    return {
      showPopup: false
    }
  },

  methods: {
    onClose() {
      this.showPopup = false
    }
  }
}
</script>

<style scoped>
.opacity-enter {
  opacity: 0;
}

.opacity-enter-active {
  transition: opacity 1s;
}

.opacity-enter-to {
  opacity: 1;
}

.opacity-leave {
  opacity: 1;
}

.opacity-leave-active {
  transition: opacity 1s;
}

.opacity-leave-to {
  opacity: 0;
}
</style>