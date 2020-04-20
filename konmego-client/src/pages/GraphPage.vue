<template>
  <div>
    <h1>Network Browser</h1>
    <div class="nav">
      <p>
        <router-link to="/login">logout</router-link>
      </p>
      <p>
        <router-link to="/home">Home</router-link>
      </p>
    </div>
    <div class="main">
    <label>
    Search: 
    <input v-model="search">
    </label>
      <Graph :graphData="graphData" v-if="graphData"></Graph>
    </div>
    <button @click="loadGraphData">Go</button>
  </div>
</template>

<script>
import { apiService } from "../_services";
import Graph from "../components/Graph";

export default {
  data() {
    return {
      graphData: undefined,
      search: undefined
    };
  },

  components: {
    Graph
  },
  methods: {
    loadGraphData() {
      apiService
      .get(`api/v1/topic_contacts/${this.search}`)
      .then(response => {
          console.log("!! search", response.data)
          return this.graphData = response.data
          });
    }
  }
};
</script>
  
