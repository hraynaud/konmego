<template>
  <div>
    <h1>Hi {{user}}</h1>
    <p> Logged in.</p>

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
