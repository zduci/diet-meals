require "spec_helper"

describe "meals/show.html.haml" do
  it "displays message if this meal does not belong to any diet" do
    assign(:widgets, [
      stub_model(Widget, :name => "slicer"),
      stub_model(Widget, :name => "dicer")
    ])

    render

    rendered.should contain("slicer")
    rendered.should contain("dicer")
  end
end
