import Vue from 'vue';
import Vuex from 'vuex';
// import { apiService } from '../_services';
//const { localStorage, sessionStorage } = window

Vue.use(Vuex);

export const store = new Vuex.Store({
    state: {
        loggedIn: false,
        user: null
    },
    mutations: {
        setLoggedInState(state, status) {
            state.loggedIn = status;
        },
        setCurrentUser(state, user) {
            state.user = user;
        },
    },
    actions: {
        logout({ commit }) {
            commit('setLoggedInState', false);
        },

        login({ commit }) {
            commit('setLoggedInState', true);
        }
    },
    getters: {}
})