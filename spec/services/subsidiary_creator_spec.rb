require 'rails_helper'

describe SubsidiaryCreator do
  describe '.create' do
    it 'should create a subsidiary' do
      create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
            third_party_insurance: 20)
      create(:category, name: 'B', daily_rate: 8, car_insurance: 15,
              third_party_insurance: 15)

      subsidiary_params = attributes_for(:subsidiary)

      result = described_class.new(subsidiary_params).create

      expect(result).to be_persisted
      expect(result.rental_prices.count).to eq(2)
    end
  end
end