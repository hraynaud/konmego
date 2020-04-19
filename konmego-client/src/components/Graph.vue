<template>
<div>
  <div id="neo4jd3"></div>
</div>

</template>

<script>
  import * as d3 from "d3";
  import Neo4jd3 from "../resources/js/neo4jd3.js";
  import InfoPanelFactory from "../resources/js/infobar.js";

export default {
  props: {
    graphData:{}
  },
  mounted() {
    window.d3 = d3;
    this.initNeo4jGraph(); 
  },
  methods: {
    initNeo4jGraph() {
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
