require "spec_helper"

describe "meals/show.html.haml" do
  it "displays message if this meal does not belong to any diet" do
    wat = double(:meal, 
                 :name => 'fries', 
                 :duration => 10, 
                 :author => stub(:author, :name => 'anon'),
                 :ingredients => [], 
                 :instructions => '', 
                 :popular_classifications => [])
    assign(:meal, wat)

    render

    rendered.should contain('This meal is not compatible with any diet')
  end
end
