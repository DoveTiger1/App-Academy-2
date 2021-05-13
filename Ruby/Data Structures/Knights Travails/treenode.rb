class PolyTreeNode
    attr_accessor :value, :parent, :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(value)
        @parent.children.delete(self) if @parent != nil
        @parent = value
        if value
            value.children << self if !value.children.include?(self)
        end
    end

    def add_child(value)
        value.parent = self
    end

    def remove_child(value)
        raise 'node is not a child' if !@children.include?(value)
        value.parent = nil
    end

    def dfs(target)
        return self if @value == target
        @children.each do |child|
            result = child.dfs(target)
            return result unless result.nil?
        end
        nil
    end
    
    def bfs(target)
        queue = [self]
        until queue.empty?
            node = queue.shift
            return node if node.value == target
            queue.concat(node.children)
        end
        nil
    end

    def inspect
        "#{@value}"
    end
end

