<template>
  <div id="neo4jd3"></div>
</template>

<script>
  import * as d3 from "d3";
  //var Neo4jd3 = require("../resources/js/neo4jd3.js");
  import Neo4jD3 from "../resources/js/neo4jd3.js";

export default {
  props: {graphData:{}},
  mounted() {
    window.d3 = d3;
    this.loadNetworkGraph();
  },
  methods: {
    loadNetworkGraph() {
      var opts = {
        icons: {},
        images: {},
        minCollision: 60,
        neo4jData: this.graphData,
        nodeRadius: 25,
        zoomFit: true
      };
        Neo4jd3("#neo4jd3", opts);
    }
  }
  };
</script>
