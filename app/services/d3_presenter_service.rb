module D3PresenterService

  class Graph

    attr_reader :data, :nodes, :links

    def initialize data, user
      @data = data
      @nodes = []
      @links = []
      @obfuscator = Obfuscator.new(user)
    end


    def to_d3 
      data.rows.each do |row|

        row.each do |col|

          if col.is_a? Array
            col.each do |obj|
              add_to_nodes_or_links obj
            end
          else
            add_to_nodes_or_links col
          end
        end
      end

      {nodes: nodes.uniq, links: links.uniq}

    end

    def add_to_nodes_or_links obj

      if obj.is_a? Neo4j::ActiveNode
        nodes << to_d3_node(obj)
      else
        links <<  to_d3_link(obj)
      end
    end

    def to_d3_link relationship
      {source: relationship.start_node_id, target: relationship.end_node_id, type: relationship.type}
    end

    def to_d3_node node

      if (node.is_a? Person or node.is_a? Endorsement)
        node = @obfuscator.obfuscate(node)
      end


      if node.type == "Person"
        {label: "#{node.name}", type: node.type, id: node.neo_id}
      else
        {label: node.try(:name) || node.description, type: node.type, id: node.neo_id}
      end

    end

  end
end
