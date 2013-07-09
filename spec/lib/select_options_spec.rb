require_relative '../../lib/select_options'

describe SelectOptions do
  context 'form pairs' do
    it 'creates form pairs for a range' do
      SelectOptions.pairs(1, 4).should == [[1, 1], [2, 2], [3, 3], [4, 4]]
    end

    it 'creates form pairs starting form 0' do
      SelectOptions.pairs(4).should == [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4]]
    end
  end

  context 'duration' do
    it 'creates form pairs for hours' do
      SelectOptions.hours.should == SelectOptions.pairs(12)
    end

    it 'creates form pairs for minutes' do
      SelectOptions.minutes.should == SelectOptions.pairs(59)
    end
  end

  context 'quantity' do
    it 'creates form pairs for quantity' do
      SelectOptions.quantities.should == SelectOptions.pairs(1, 30)
    end
  end
end
