import Vue from 'vue';
import Router from 'vue-router';
import HomePage from '../home/HomePage'
import LoginPage from '../login/LoginPage'
import { authService } from './auth.service'

Vue.use(Router);

export const router = new Router({
  mode: 'history',
  routes: [
    { path: '/', component: HomePage },
    { path: '/login', component: LoginPage },

    // otherwise redirect to home
    { path: '*', redirect: '/' }
  ]
});

router.beforeEach((to, from, next) => {
  // redirect to login page if not logged in and trying to access a restricted page
  const publicPages = ['/login'];
  const authRequired = !publicPages.includes(to.path);
  const isLoggedIn = authService.currentUser();
  if (authRequired && !isLoggedIn) {
    return next({ 
      path: '/login', 
      query: { returnUrl: to.path }
    });
  }

  next();
})