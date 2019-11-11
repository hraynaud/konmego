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
      <div id="neo4jd3"></div>
    </div>
  </div>
</template>

<script>
import { apiService } from "../_services";
import * as d3 from "d3";



require("../resources/js/neo4jd3.js");
export default {
  data() {
    return {
      graphData: []
    };
  },
  mounted() {
    this.loadNetworkGraph();
    window.d3 = d3;
  },
  methods: {
    loadNetworkGraph() {
      apiService.get("api/v1/topic_contacts/Cooking").then(response => {
        this.graphData = response.data;
        var neo4j =  Neo4jd3("#neo4jd3", {
          icons: {},
          images: {},
          minCollision: 60,
          neo4jData: response.data,
          nodeRadius: 25,
          zoomFit: true
        });
      });
    }
  }
};
</script>
