class FoodGraph
  def self.connect(parent, child)
    unless FoodConnection.find_by_parent_food_id_and_child_food_id(parent, child)
      FoodConnection.create(:parent_food => parent,
                            :child_food => child)
    end
  end

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

  private
  def self.traverse_graph(food, method, result=[])
    food.send(method).each do |element|
      result << element.name
      traverse_graph(element, method, result)
    end
    result
  end

  def self.search_graph(food, target, method)
    food.send(method).each do |element|
      return true if element.name == target || 
                     search_graph(element, target, method)
    end
    false
  end

end
