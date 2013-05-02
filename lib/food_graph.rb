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

  def self.has_ancestors(food, ancestor)
    search_ancestors(food, ancestor)
  end

  private
  def self.traverse_graph(food, method, result=[])
    food.send(method).each do |element|
      result << element.name
      traverse_graph(element, method, result)
    end
    result
  end

  def self.search_ancestors(food, ancestor)
    food.parent_foods.each do |element|
      return true if element.name == ancestor || 
                     search_ancestors(element, ancestor)
    end
    false
  end
end
