<template>
  <div>
    <h1>Network Browser</h1>
      <Graph :graphData="graphData" v-if="graphData"></Graph>
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
  