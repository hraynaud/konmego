<template>
  <div>
    <h1>Hi {{user}}</h1>
    <p>You're logged in with Vue.js & Basic HTTP Authentication!!</p>
    <h3>Users from secure api end point:</h3>
    
     <p>
      <router-link to="/login">logout</router-link>
    </p>
    <p>
      <router-link to="/home">Home</router-link>
    </p>
   
    <p>
      <router-link to="/projects">Projects</router-link>
    </p>
  </div>
</template>

<script>
export default {
  props:{
    user: String
  },
};
</script>