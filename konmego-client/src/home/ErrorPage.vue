<template>
  <div>
    <h1>ERROR</h1>
    <h2>{{message}}</h2>
    <p>
      <router-link to="/home">Home</router-link>
    </p>
 
  </div>
</template>

<script>
export default {
  props:{
    message: String
  },
};
</script>