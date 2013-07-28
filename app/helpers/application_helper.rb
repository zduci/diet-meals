module ApplicationHelper
  def ingredient_attributes(f)
    f.fields_for(:ingredients, Ingredient.new, :child_index => "new_ingredient") do |builder|
      render 'ingredient_fields', :f => builder
    end
  end
end
