//(function(){
var oWebViewInterface = window.nsWebViewInterface;

window.changeColor = function(){
 initGraph();
}


window.onload = function (){
  oWebViewInterface.emit('loaded', {"booga": "loo"});
}

window.initGraph =  function() {
  var neo4jd3 = new Neo4jD3('#neo4jd3', {
    minCollision: 60,
    neo4jDataUrl: '/api/v1/topic_contacts/'+ window.topic,
    neo4jJsonAuthHeader: window.auth,
    nodeRadius: 25,
  });

}


