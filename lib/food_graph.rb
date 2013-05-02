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

  private
  def self.traverse_ancestors(food, ancestors)
    food.parent_foods.each do |parent|
      ancestors << parent.name
      traverse_ancestors(parent, ancestors)
    end
    ancestors
  end
end
