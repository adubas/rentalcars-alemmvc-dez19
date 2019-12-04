require 'rails_helper'

describe RentalActionPolicy do
  describe '.authorized?' do
    it 'should authorize admin' do
      subsidiary = create(:subsidiary, name: 'Almeida Motors')
      user = create(:user, role: :admin)
      category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                        third_party_insurance: 20)
      car_model = create(:car_model, name: 'Sedan',
                        category: category)
      car = create(:car, car_model: car_model, license_plate: 'TAT-1234',
                  subsidiary: subsidiary)
      rental = create(:rental, category: category, subsidiary: subsidiary,
                      start_date: '3000-01-08', end_date: '3000-01-10',
                      status: :finalized)

      expect(described_class.new(rental, user)).to be_authorized
    end

    it 'should authorized same subsidiary users' do
      subsidiary = create(:subsidiary, name: 'Almeida Motors')
      user = create(:user, subsidiary: subsidiary)
      category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                        third_party_insurance: 20)
      car_model = create(:car_model, name: 'Sedan',
                        category: category)
      car = create(:car, car_model: car_model, license_plate: 'TAT-1234',
                  subsidiary: subsidiary)
      rental = create(:rental, category: category, subsidiary: subsidiary,
                      start_date: '3000-01-08', end_date: '3000-01-10',
                      status: :finalized)
                      
      expect(described_class.new(rental, user)).to be_authorized
    end

    it 'should not authorize other subsidiary user' do
      subsidiary = create(:subsidiary, name: 'Almeida Motors')
      other_subsidiary = create(:subsidiary)
      user = create(:user, subsidiary: other_subsidiary)
      category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                        third_party_insurance: 20)
      car_model = create(:car_model, name: 'Sedan',
                        category: category)
      car = create(:car, car_model: car_model, license_plate: 'TAT-1234',
                  subsidiary: subsidiary)
      rental = create(:rental, category: category, subsidiary: subsidiary,
                      start_date: '3000-01-08', end_date: '3000-01-10',
                      status: :finalized)
                      
      expect(described_class.new(rental, user)).not_to be_authorized
    end
  end
end