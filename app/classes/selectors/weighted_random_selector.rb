module Selectors
  class WeightedRandomSelector
    def initialize(data_selected_from, data_weights = nil)
      @data_selected_from = data_selected_from
      @data_weights       = data_weights || create_default_data_weights(data_selected_from)
    end

    def select(select_count)
      if select_count > @data_selected_from.size
        raise ArgumentError.new("Select count [#{select_count}] is over the size of data")
      end

      weighted_random_select(select_count)
    end

    # Use a binary tree and a node contains a Hashie::Mash(data, weight, total_weight, index)
    # to pick a data with pobablity based on their weight randomly
    #
    def weighted_random_select(select_count)
      tree = create_binary_tree

      select_count.times.map { pop_data_from_tree(tree) }
    end

    # The tree is store in the array
    # parent_index = i
    # left_node_index  = 2 * i + 1
    # right_node_index = 2 * i + 2
    #
    def create_binary_tree
      tree = []

      # initialize the tree
      @data_selected_from.each_with_index do |data, index|
        weight = @data_weights[index]

        tree << Hashie::Mash.new(:data => data, :weight => weight, :total_weight => weight, :node_index => index)
      end

      # populate the total_weight
      (tree.size - 1).downto(0).each_with_index do |node_index|
        node        = tree[node_index]
        left_index  = left_node_index(node_index)
        right_index = right_node_index(node_index)

        node.total_weight += tree[left_index].total_weight  if left_index < tree.size
        node.total_weight += tree[right_index].total_weight if right_index < tree.size
      end

      tree
    end

    # pop out a node data from a tree
    # after each pop up, it needs to update the total weigths of its
    # parent node, and set its weight to 0
    #
    def pop_data_from_tree(tree)
      # choose the random weight from total_weight
      random_weight = rand() * tree.first.total_weight

      picked_node = pick_a_node(tree, tree[0], 0, random_weight)

      # udpate the total weight of its parent node
      reduce_parent_total_weight_with_weight(tree, picked_node, picked_node.weight)

      # set its weight to 0 becase it is picked
      picked_node.weight = 0

      picked_node.data
    end

    # Pick a node has weight > random weight then return that node,
    # elsif node.left_node.total_weight > weight (random weight - node.weight), then continue to find
    # it from its left branch
    # elsif node.right_node.total_weight > weight (random weight - node.weight - node.left_node.total_weight)
    # , then continue to find it from its right branch
    def pick_a_node(tree, node, node_index, random_weight)
      raise ArgumentError.new("node cannot be nil") if node.nil?

      # pick a node with weight > random_weight
      return node if node.weight > random_weight
      rest_random_weight = random_weight - node.weight

      left_index = left_node_index(node_index)

      if tree[left_index].total_weight > rest_random_weight
        pick_a_node(tree, tree[left_index], left_index, rest_random_weight)
      else
        rest_random_weight -= tree[left_index].total_weight
        right_index = right_node_index(node_index)
        pick_a_node(tree, tree[right_index], right_index, rest_random_weight)
      end
    end

    # Removed weight from node.total_weight
    def reduce_parent_total_weight_with_weight(tree, node, weight)
      node.total_weight -= weight

      # return if node is the root of the tree
      return if node.node_index == 0

      parent_node  = tree[find_parent_idx_from_idx(node.node_index)]

      reduce_parent_total_weight_with_weight(tree, parent_node, weight)
    end

    def left_node_index(index)
      index * 2 + 1
    end

    def right_node_index(index)
      index * 2 + 2
    end

    # Find the parent index fromt he child index
    #
    # @params idx [Fixnum] eithe left child index or right child index
    # @returns [Fixnum] Parent index
    def find_parent_idx_from_idx(idx)
      if idx < 2
        return 0
      end

      if idx % 2 == 0
        ((idx - 1.0) / 2).floor
      else
        ((idx - 2.0) / 2).ceil
      end
    end

    # It should returnt the max number of that range in the
    # array.
    # @params size [Fixnum] size of the array
    # @returns [Array] if data.size == 2, then it should return [1,3]
    def create_default_data_weights(data)
      data_weights = []
      sum = 0
      1.upto(data.size).each do |data_index|
        sum += data_index
        data_weights << sum
      end
      data_weights
    end
  end
end