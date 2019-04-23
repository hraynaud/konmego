import Vue from 'vue'
import './registerServiceWorker'
import { router, eventService } from './_services';
import App from './app/App';
import './../node_modules/bulma/css/bulma.css';

Vue.config.productionTip = false

new Vue({
    el: '#app',
    router,

  mounted: function() {
    eventService.$on("logged-in", (payload) => {
        console.log(`logged in as: ${payload.first} ${payload.last}`);
    });
    eventService.$on("logged-off", () => {
       console.log("Logged Out");
    });
  },
    render: h => h(App)
});
