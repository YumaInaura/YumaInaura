import Vue from 'vue';
import VueLogger from 'vuejs-logger';

Vue.use(VueLogger, <%= serialize(options) %>);

