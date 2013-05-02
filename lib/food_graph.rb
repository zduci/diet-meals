class FoodGraph
  def self.connect(parent, child)
    unless FoodConnection.find_by_parent_food_id_and_child_food_id(parent, child)
      FoodConnection.create(:parent_food => parent,
                            :child_food => child)
    end
  end

  def self.find_ancestors(food)
    traverse_ancestors(food, [])
  end

  def self.find_descendants(food)
    traverse_descendants(food, [])
  end

  private
  def self.traverse_ancestors(food, ancestors)
    food.parent_foods.each do |parent|
      ancestors << parent.name
      traverse_ancestors(parent, ancestors)
    end
    ancestors
  end

  def self.traverse_descendants(food, descendants)
    food.child_foods.each do |child|
      descendants << child.name
      traverse_descendants(child, descendants)
    end
    descendants
  end
end
