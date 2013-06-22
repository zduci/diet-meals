require_relative '../../lib/meal_duration'

describe MealDuration do
  it 'creates form pairs' do
    MealDuration.pairs(4).should == [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4]]
  end

  it 'creates form pairs for hours' do
    MealDuration.hours.should == MealDuration.pairs(12)
  end

  it 'creates form pairs for minutes' do
    MealDuration.minutes.should == MealDuration.pairs(59)
  end
end
