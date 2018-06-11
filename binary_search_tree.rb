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

    def get_parent(value, node=@root_node, parent_node=nil)
        return nil if node.nil?
        if value < node.value
            get_parent(value, node.left_node, node)
        elsif value > node.value
            get_parent(value, node.right_node, node)
        else
            return parent_node
        end
    end

    def remove(node_value, node=@root_node)
        parent = self.get_parent(node_value) if focus_node != @root_node
        if focus_node.left_node.nil? && focus_node.right_node.nil?
            # The node has NO leafs
            if focus_node == @root_node
                # The node is root
                @root_node = nil
            else
                # The Node is not the root
                parent.right_node == node ? parent.right_node = nil : parent.left_node = nil
            end
        elsif focus_node.left_node.nil?
            # The node has no left leaf
            if focus_node == @root_node
                # The node is a root
                @root = focus_node.right_node
            elsif parent.right_node == focus_node
                # The node is a right child
                parent.right_node = focus_node.right_node
            elsif parent.left_node == focus_node
                # The node is a left child
                parent.left_node = focus_node.right_node
            end
        elsif focus_node.right_node.nil?
            #The node has not right leaf
            if focus_node == @root
                @root = focus_node.left_node
            elsif parent.right_node == focus_node
                parent.right_node = focus_node.left_node
            elsif parent.left_node == focus_node
                parent.left_node = focus_node.left_node
            end
        else
            #The node has both leafs
        end

            

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

puts "\nGet parent of node: \n"
puts search_tree.get_parent(5).to_s