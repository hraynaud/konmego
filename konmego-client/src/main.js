import Vue from 'vue'
// import App from './App.vue'
// import router from './router'
// import axios from 'axios'
import './registerServiceWorker'



import { router } from './_services';
import App from './app/App';

Vue.config.productionTip = false

// new Vue({
//   router,
//   methods: {
//     writeToApi: function(payload){
//       axios.post(url, payload.data, {reponseType: 'json'})
//       .then(function (response) {

//       })
//       .catch(function (error) {
//       })
//     }
//   },
//   render: h => h(App)
// }).$mount('#app')




new Vue({
    el: '#app',
    router,
    render: h => h(App)
});
