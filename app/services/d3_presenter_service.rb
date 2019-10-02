module D3PresenterService


  class Graph

    attr_reader :data

    def initialize data
      @data = data.response
    end


    def to_d3 
      nodes = []
      links = []
      data.rows.each do |row|
        row.each do |col|
          if col.is_a? Neo4j::ActiveNode
            nodes << to_d3_node(col)
          else
            if col.is_a? Array
              col.each do |rel|
                links <<  to_d3_link(rel)
              end
            else
              links <<  to_d3_link(col)
            end
          end
        end
      end

      {nodes: nodes, links: links}

    end


  def to_d3_link relationship
    {source: relationship.start_node_id, target: relationship.end_node_id, type: relationship.type}
  end

  def to_d3_node node
    if node.is_a? Person
      {label: "#{node.first_name} #{node.last_name}", type: "Person", id: node.neo_id}
    else
      {label: node.try(:name) || node.description, type: node.class.name, id: node.neo_id}
    end
  end

  end
end
