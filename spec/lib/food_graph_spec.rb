require_relative '../../lib/food_graph'

describe FoodGraph do
  context 'ancestors' do
    let(:fruit) { stub(:fruit, :name => :fruit, :child_foods => [], :parent_foods => []) }
    let(:apple) { stub(:apple, :name => :apple, :child_foods => [], :parent_foods => [fruit]) }
    let(:citrus) { stub(:citrus, :name => :citrus, :child_foods => [], :parent_foods => [fruit]) }
    let(:orange) { stub(:orange, :name => :orange, :child_foods => [], :parent_foods => [citrus, sugar]) }
    let(:sugar) { stub(:sugar, :name => :sugar, :child_foods => [], :parent_foods => []) }

    it 'retrieves all ancestors' do
      FoodGraph.find_ancestors(orange).should =~ [fruit, citrus, sugar]
    end

    it 'checks for ancestor' do
      FoodGraph.has_ancestor(orange, fruit).should be_true
      FoodGraph.has_ancestor(orange, apple).should be_false
    end

    it 'returns the foods along with their ancestors' do
      FoodGraph.including_ancestors([apple, orange]).should == [apple, orange, fruit, citrus, sugar]
    end
  end

  context 'descendants' do
    let(:fruit) { stub(:fruit, :name => :fruit, :child_foods => [apple, citrus], :parent_foods => []) }
    let(:apple) { stub(:apple, :name => :apple, :child_foods => [], :parent_foods => []) }
    let(:citrus) { stub(:citrus, :name => :citrus, :child_foods => [orange], :parent_foods => []) }
    let(:orange) { stub(:orange, :name => :orange, :child_foods => [], :parent_foods => []) }
    let(:sugar) { stub(:sugar, :name => :sugar, :child_foods => [orange], :parent_foods => []) }

    it 'retrieves all descendants' do
      FoodGraph.find_descendants(fruit).should =~ [apple, citrus, orange]
    end

    it 'checks for descendant' do
      FoodGraph.has_descendant(citrus, orange).should be_true
      FoodGraph.has_descendant(citrus, apple).should be_false
    end

    it 'returns the foods along with their descendants' do
      FoodGraph.including_descendants([citrus, sugar]).should =~ [citrus, orange, sugar]
    end
  end
end
