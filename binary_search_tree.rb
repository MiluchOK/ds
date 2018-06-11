class BinarySearchTree
    attr_reader :root_node

    def initialize
        @root_node = nil
    end

    def insert(node_value)
        if @root_node.nil?
            @root_node = Node.new(node_value)
        else
            @root_node.insert(node_value)
        end
    end

    def in_order(node=@root_node, &block)
        return if node.nil?
        in_order(node.left_node, &block)
        yield node
        in_order(node.right_node, &block)
    end

    def pre_order(node=@root_node, &block)
        return if node.nil?
        yield node
        pre_order(node.left_node, &block)
        pre_order(node.right_node, &block)
    end

    def post_order(node=@root_node, &block)
        return if node.nil?
        post_order(node.left_node, &block)
        post_order(node.right_node, &block)
        yield node
    end

    def search(value, node=@root_node)
        return nil if node.nil?
        if value < node.value
            search(value, node.left_node)
        elsif value > node.value
            search(value, node.right_node)
        else
            return node
        end
    end

    class Node
        attr_reader :value, :right_node, :left_node
    
        def initialize(value)
            @value = value
            @left_node = nil
            @right_node = nil
        end

        def insert( node_value )
            if  node_value <= value
                @left_node.nil? ? @left_node = Node.new(node_value) : @left_node.insert(node_value)
            else
                @right_node.nil? ? @right_node = Node.new(node_value) : @right_node.insert(node_value)
            end
        end

        def to_s
            return @value
        end
    end
end


search_tree = BinarySearchTree.new
search_tree.insert(10)
search_tree.insert(12)
search_tree.insert(4)
search_tree.insert(1)
search_tree.insert(14)
search_tree.insert(5)
search_tree.insert(7)
search_tree.insert(8)
search_tree.insert(100)

puts "In order: \n"
search_tree.in_order do |node|
    puts(node.to_s)
end

puts "\n pre-order:\n"
search_tree.pre_order do |node|
    puts(node.to_s)
end

puts "\n post-order:\n"
search_tree.post_order do |node|
    puts(node.to_s)
end

puts "Search a node: "
puts search_tree.search(12).to_s