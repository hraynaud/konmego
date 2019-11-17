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
      <Graph :graphData="graphData" v-if="graphData"></Graph>
    </div>
  </div>
</template>

<script>
import { apiService } from "../_services";
import Graph from "../components/Graph";

export default {
  data() {
    return {
      graphData: undefined,
    };
  },

  components: {
    Graph
  },

  mounted() {
    this.loadGraphData();
  },
  methods: {
    loadGraphData() {
      apiService
      .get("api/v1/topic_contacts/Cooking")
      .then(response => this.graphData = response.data);
    }
  }
};
</script>
  