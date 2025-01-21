function InfoPanelFactory(){
  function appendInfoPanel(container) {
    return container.append('div')
      .attr('class', 'neo4jd3-info');
  }

  function appendInfoElement(cls, isNode, property, value) {
    var elem = info.append('a');

    elem.attr('href', '#')
      .attr('class', cls)
      .html('<strong>' + property + '</strong>' + (value ? (': ' + value) : ''));

    if (!value) {
      elem.style('background-color', function(d) {
        return options.nodeOutlineFillColor ? options.nodeOutlineFillColor : (isNode ? class2color(property) : defaultColor());
      })
        .style('border-color', function(d) {
          return options.nodeOutlineFillColor ? class2darkenColor(options.nodeOutlineFillColor) : (isNode ? class2darkenColor(property) : defaultDarkenColor());
        })
        .style('color', function(d) {
          return options.nodeOutlineFillColor ? class2darkenColor(options.nodeOutlineFillColor) : '#fff';
        });
    }
  }

  function appendInfoElementClass(cls, node) {
    appendInfoElement(cls, true, node);
  }

  function appendInfoElementProperty(cls, property, value) {
    appendInfoElement(cls, false, property, value);
  }

  function appendInfoElementRelationship(cls, relationship) {
    appendInfoElement(cls, false, relationship);
  }

  function clearInfo() {
    info.html('');
  }

  function updateInfo(d) {
    //clearInfo();

    if (d.labels) {
      appendInfoElementClass('class', d.labels[0]);
    } else {
      appendInfoElementRelationship('class', d.type);
    }

    appendInfoElementProperty('property', '&lt;id&gt;', d.id);

    Object.keys(d.properties).forEach(function(property) {
      appendInfoElementProperty('property', property, JSON.stringify(d.properties[property]));
    });
  }

  return {

    appendInfoPanel: appendInfoPanel,
    appendInfoElement: appendInfoElement,
    appendInfoElementClass: appendInfoElementClass,
    appendInfoElementProperty: appendInfoElementProperty,
    appendInfoElementRelationship: appendInfoElementRelationship,
    updateInfo: updateInfo
  }
}

//module.exports = InfoBar;
