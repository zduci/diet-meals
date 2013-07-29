module MealsHelper
  def ingredient_attributes(f)
    attributes = f.fields_for(:ingredients, Ingredient.new, :child_index => "new_ingredient") do |builder|
      render 'ingredient_fields', :f => builder
    end
    '"' + escape_javascript(attributes) + '"'
  end
end
