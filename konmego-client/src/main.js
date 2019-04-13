import Vue from 'vue'
import './registerServiceWorker'
import { router } from './_services';
import App from './app/App';

Vue.config.productionTip = false

new Vue({
    el: '#app',
    router,
    render: h => h(App)
});
