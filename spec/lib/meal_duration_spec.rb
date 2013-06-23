require_relative '../../lib/meal_duration'

describe MealDuration do
  context 'converts hours and minutes to minutes' do
    it 'works with integers' do
      MealDuration.to_minutes(8, 20).should == 500
    end

    it 'works with strings' do
      MealDuration.to_minutes('8', '20').should == 500
    end
  end
end
