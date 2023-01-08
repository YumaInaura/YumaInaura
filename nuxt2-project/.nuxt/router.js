import Vue from 'vue'
import Router from 'vue-router'
import { normalizeURL, decode } from 'ufo'
import { interopDefault } from './utils'
import scrollBehavior from './router.scrollBehavior.js'

const _10dcd6fc = () => interopDefault(import('../pages/child.vue' /* webpackChunkName: "pages/child" */))
const _15d7773e = () => interopDefault(import('../pages/clickaxios.vue' /* webpackChunkName: "pages/clickaxios" */))
const _38c06092 = () => interopDefault(import('../pages/closable.vue' /* webpackChunkName: "pages/closable" */))
const _2d41cd88 = () => interopDefault(import('../pages/map.vue' /* webpackChunkName: "pages/map" */))
const _a3fa3c0c = () => interopDefault(import('../pages/parent.vue' /* webpackChunkName: "pages/parent" */))
const _1c61eae8 = () => interopDefault(import('../pages/popup.vue' /* webpackChunkName: "pages/popup" */))
const _05f6a165 = () => interopDefault(import('../pages/trantision.vue' /* webpackChunkName: "pages/trantision" */))
const _3331809c = () => interopDefault(import('../pages/index.vue' /* webpackChunkName: "pages/index" */))

const emptyFn = () => {}

Vue.use(Router)

export const routerOptions = {
  mode: 'history',
  base: '/',
  linkActiveClass: 'nuxt-link-active',
  linkExactActiveClass: 'nuxt-link-exact-active',
  scrollBehavior,

  routes: [{
    path: "/child",
    component: _10dcd6fc,
    name: "child"
  }, {
    path: "/clickaxios",
    component: _15d7773e,
    name: "clickaxios"
  }, {
    path: "/closable",
    component: _38c06092,
    name: "closable"
  }, {
    path: "/map",
    component: _2d41cd88,
    name: "map"
  }, {
    path: "/parent",
    component: _a3fa3c0c,
    name: "parent"
  }, {
    path: "/popup",
    component: _1c61eae8,
    name: "popup"
  }, {
    path: "/trantision",
    component: _05f6a165,
    name: "trantision"
  }, {
    path: "/",
    component: _3331809c,
    name: "index"
  }],

  fallback: false
}

export function createRouter (ssrContext, config) {
  const base = (config._app && config._app.basePath) || routerOptions.base
  const router = new Router({ ...routerOptions, base  })

  // TODO: remove in Nuxt 3
  const originalPush = router.push
  router.push = function push (location, onComplete = emptyFn, onAbort) {
    return originalPush.call(this, location, onComplete, onAbort)
  }

  const resolve = router.resolve.bind(router)
  router.resolve = (to, current, append) => {
    if (typeof to === 'string') {
      to = normalizeURL(to)
    }
    return resolve(to, current, append)
  }

  return router
}
