<template>
  <div>
    <h1>Project List</h1>
    <div class="nav">
      <p>
        <router-link to="/login">logout</router-link>
      </p>
      <p>
        <router-link to="/home">Home</router-link>
      </p>
    </div>
    <div class="main">
      <ul>
        <li v-for="p in projects" :key="p.id" >{{p.name}}</li>
      </ul>
    </div>
  </div>
</template>

<script>
import { apiService } from "../_services";
export default {
  data() {
    return{
      projects: []
    }
  },
  mounted() {
      //alert(this.projects.size);
  },
  methods: {
    loadProjects(vm) {
      apiService
        .get("api/v1/projects")
        .then(function(response) {
          vm.projects = response.data.sort(function(a, b) {
   
            return a.name > b.name ? 1 : -1;
          });
        })
        .catch(function(error) {
            vm.$router.push("/error");
        });
    }
  },

  beforeRouteEnter: function(to, from, next) {
    next(vm =>vm.loadProjects(vm))
  }
};
</script>
