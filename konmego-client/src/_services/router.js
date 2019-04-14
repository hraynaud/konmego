import Vue from 'vue';
import Router from 'vue-router';
import HomePage from '../home/HomePage'
import LoginPage from '../login/LoginPage'
import { authService } from './auth.service'

Vue.use(Router);



export const router = new Router({
  mode: 'history',
  routes: [
    { path: '/', component: HomePage, props: loggedInUser },
    { path: '/login', component: LoginPage },

    // otherwise redirect to home 
    { path: '*', redirect: '/' }
  ]
}); 

function loggedInUser(route){
  return {user: authService.currentUser().first}
}

router.beforeEach((to, from, next) => {
  // redirect to login page if not logged in and trying to access a restricted page
  const publicPages = ['/login'];
  const authRequired = !publicPages.includes(to.path);

  if (authRequired && !authService.currentUser()) {
    return next({ 
      path: '/login', 
      query: { returnUrl: to.path }
    });
  }

  next();
})