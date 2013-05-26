require 'spec_helper'
require_relative '../../lib/meal_classifier'

describe MealClassifier do

  context 'MealClassifier#classify' do
    before(:all) do
      @egg = FactoryGirl.create(:egg)
      @boiled_egg = FactoryGirl.build(:boiled_egg, :foods => [@egg])
      @eggs_only = FactoryGirl.create(:eggs_only, :allowed_foods => [@egg])

      @carrot = FactoryGirl.create(:carrot)
      @boiled_carrot = FactoryGirl.build(:boiled_carrot, :foods => [@carrot])
      @carrots_only = FactoryGirl.create(:carrots_only, :allowed_foods => [@carrot])
    end

    it 'classifies boiled egg as compatible with eggs only diet' do
      MealClassifier.classify(@boiled_egg).should == [@eggs_only]
    end

    it 'classifies boiled egg as compatible with eggs only diet' do
      MealClassifier.classify(@boiled_carrot).should == [@carrots_only]
    end
  end
end
