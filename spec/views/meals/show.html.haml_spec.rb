require "spec_helper"

describe "meals/show.html.haml" do
  it "displays message if this meal does not belong to any diet" do
    meal = double(:meal, 
                 :name => 'fries', 
                 :duration => 10, 
                 :author => double(:author, :name => 'anon'),
                 :ingredients => [], 
                 :instructions => '', 
                 :popular_classifications => [])
    assign(:meal, meal)

    render

    rendered.should contain('This meal is not compatible with any diet')
  end
end
