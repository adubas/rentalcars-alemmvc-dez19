require 'rails_helper'

describe CancelScheduledRentalJob do
  
  describe '.auto_enqueue' do
    it 'should auto enqueue' do
      described_class.auto_enqueue(Date.current)
      expect(Delayed::Worker.new.work_off).to eq [1,0]
    end
  end

  describe '.perform' do
    it 'should cancel past rentals' do
      subsidiary = create(:subsidiary)
      category = create(:category)
      create_list(:car, 10, subsidiary: subsidiary, category: category)
      old_rental = create(:rental, subsidiary: subsidiary, category: category, 
                                  start_date: 10.days.ago, end_date: 2.days.ago, 
                                  status: :scheduled)
      future_rental = create(:rental, subsidiary: subsidiary, category: category, 
                                      start_date: 1.day.from_now, end_date: 2.days.from_now, 
                                      status: :scheduled)

      described_class.auto_enqueue(Date.current)
      Delayed::Worker.new.work_off

      old_rental.reload
      future_rental.reload
      
      expect(old_rental).to be_canceled
      expect(future_rental).to be_scheduled
    end
  end
end