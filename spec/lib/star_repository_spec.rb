require 'spec_helper'

describe StarRepository do
  describe 'AddStar#add' do
    let(:classification_id) { 1 }
    let(:user) { stub(:user) }
    let(:count) { 1 }

    before(:each) do
      MealDietClassification.stub(:stars_count).with(classification_id) { count }
    end
    
    it 'adds a new star' do
      Star.should_receive(:create_star).with(classification_id, user)
      StarRepository.add(classification_id, user)
    end

    context 'adds star succesfully' do
      it 'returns the number of stars for the classification id' do
        Star.stub(:create_star).with(classification_id, user) { true }
        StarRepository.add(classification_id, user).should == count
      end
    end

    context 'fails to add star' do
      it 'returns false' do
        Star.stub(:create_star).with(classification_id, user) { false }
        StarRepository.add(classification_id, user).should == false
      end
    end
  end
end
