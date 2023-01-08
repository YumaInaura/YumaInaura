// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  vite:{
    server: {
      watch: {
        usePolling: true,
      },
    },
  },
  plugins: [
    // {
    //   src: '@/plugins/plugin',
    //   mode: 'client'
    // }
  ]

})
