import Vue from 'vue'
import { router } from './_services';
import {store} from './store'
import App from './App';
import './registerServiceWorker'
import './../../node_modules/bulma/css/bulma.css';

Vue.config.productionTip = false

new Vue({
    el: '#app',
    router,
    store,

    render: h => h(App)
});
