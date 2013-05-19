class FoodGraph
  def self.find_ancestors(food)
    traverse_graph(food, :parent_foods)
  end

  def self.find_descendants(food)
    traverse_graph(food, :child_foods)
  end

  def self.has_ancestor(food, ancestor)
    search_graph(food, ancestor, :parent_foods)
  end

  def self.has_descendant(food, descendant)
    search_graph(food, descendant, :child_foods)
  end

  def self.including_ancestors(foods)
    including(:find_ancestors, foods)
  end

  def self.including_descendants(foods)
    including(:find_descendants, foods)
  end

  private
  def self.including(method, foods)
    foods.inject(foods) do |result, food|
      result + FoodGraph.send(method, food)
    end.uniq
  end

  def self.traverse_graph(food, method, result=[])
    food.send(method).each do |element|
      result << element
      traverse_graph(element, method, result)
    end
    result
  end

  def self.search_graph(food, target, method)
    food.send(method).each do |element|
      return true if element == target || 
                     search_graph(element, target, method)
    end
    false
  end
end
