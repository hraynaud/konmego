import Vue from 'vue';

import { router } from './_services';
import App from './app/App';

new Vue({
    el: '#app',
    router,
    render: h => h(App)
});
