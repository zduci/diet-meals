class FoodGraph
  def self.connect(parent, child)
    FoodConnection.create(:parent_food => parent,
                          :child_food => child)
  end
end
