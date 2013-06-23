describe SelectOptions do
  context 'form pairs' do
    it 'creates form pairs for a range' do
      MealDuration.pairs(1, 4).should == [[1, 1], [2, 2], [3, 3], [4, 4]]
    end

    it 'creates form pairs starting form 0' do
      MealDuration.pairs(4).should == [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4]]
    end
  end

  context 'duration' do
    it 'creates form pairs for hours' do
      MealDuration.hours.should == MealDuration.pairs(12)
    end

    it 'creates form pairs for minutes' do
      MealDuration.minutes.should == MealDuration.pairs(59)
    end
  end
end
