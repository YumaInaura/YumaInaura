import './bootstrap';

import Alpine from 'alpinejs';

window.Alpine = Alpine;

Alpine.start();

import axios from "axios";
window.axios = axios;

window.axios.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest";

// import { createApp } from "vue";
// import './bootstrap';
// import '../css/app.css';
// import {createApp} from 'vue'
// import App from './App.vue'
// createApp(App).mount("#app")
// const app = createApp();

// console.log(app.version);

// app.mount("#app");


import './bootstrap';
import '../css/app.css';
import {createApp} from 'vue'
import App from './App.vue'
createApp(App).mount("#app")
