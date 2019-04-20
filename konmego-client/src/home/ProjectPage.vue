<template>
  <div>
    <h1>Project Page {{project}}</h1>

    <p>
      <router-link to="/login">logout</router-link>
    </p>
    <p>
      <router-link to="/home">Home</router-link>
    </p>
  </div>
</template>

<script>
import { apiService } from "../_services";
export default {
  props: {
    project: String
  },
  beforeRouteEnter: function(to, from, next) {
    apiService
      .readFromApi("api/v1/projects")
      .then(function(response) {
        next();
      })
      .catch(function(error) {
        //next(error)
        next((vm) => {vm.$router.push("/error")});
      });
  }
};  
</script>