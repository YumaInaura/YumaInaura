// https://nuxtjs.org/guide/vuex-store

export const state = () => ({
  counter: 0
})

export const mutations = {
  increment (state) {
    state.counter++
  }
}

