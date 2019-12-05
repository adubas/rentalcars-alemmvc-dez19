require 'rails_helper'

describe RentalBuilder do
  describe '.build' do
    it 'should build a rental instance' do
      client = create(:client)
      category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                        third_party_insurance: 20)
      subsidiary = create(:subsidiary)
      car_model = create(:car_model, category: category)
      create(:car, car_model: car_model, subsidiary: subsidiary)
      rental_params = build(:rental, client: client, category: category).attributes

      allow(TokenGenerator).to receive(:generate).and_return('ABC123')

      result = described_class.new(rental_params, subsidiary).build

      expect(result).to be_valid
      expect(result).to be_scheduled
      expect(result.subsidiary).to eq subsidiary
      expect(result.reservation_code).to eq 'ABC123'
    end

    it 'should build a rental instance' do
      client = create(:client)
      category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                        third_party_insurance: 20)
      subsidiary = create(:subsidiary)
      car_model = create(:car_model, category: category)
      create(:car, car_model: car_model, subsidiary: subsidiary)
      rental_params = build(:rental, client: client, category: category).attributes

      allow(OtherTokenGenerator).to receive(:generate).and_return('AB16bg')

      result = described_class.new(rental_params, subsidiary, OtherTokenGenerator).build

      expect(result).to be_valid
      expect(result).to be_scheduled
      expect(result.subsidiary).to eq subsidiary
      expect(result.reservation_code).to eq 'AB16bg'
    end
  end
end