import Vue from 'vue'
import './registerServiceWorker'
import { router } from './_services';
import App from './app/App';
import './../node_modules/bulma/css/bulma.css';

Vue.config.productionTip = false

new Vue({
    el: '#app',
    router,

    render: h => h(App)
});
