require 'rails_helper'

describe RentalByCategoryAndSubsidiaryQuery do
  describe '.call' do
    it 'should filter by category and subsidiary' do
      subsidiary = create(:subsidiary, name: 'Paulista')
      other_subsidiary = create(:subsidiary, name: 'Bela Vista')
      category_a = create(:category, name: 'A')
      category_b = create(:category, name: 'B')
      start_at = '2020-1-1'
      end_at = '2022-1-10'
      create_list(:car, 10, category: category_a, subsidiary: subsidiary)
      create_list(:car, 10, category: category_b, subsidiary: subsidiary)
      create_list(:car, 10, category: category_a, subsidiary: other_subsidiary)
      create_list(:car, 10, category: category_b, subsidiary: other_subsidiary)
      create_list(:rental, 5, category: category_a, subsidiary: subsidiary,
                              start_date: start_at, end_date: end_at)
      create_list(:rental, 4, category: category_b, subsidiary: subsidiary,
                              start_date: start_at, end_date: end_at)
      create_list(:rental, 3, category: category_a, subsidiary: other_subsidiary,
                              start_date: start_at, end_date: end_at)
      create_list(:rental, 2, category: category_b, subsidiary: other_subsidiary,
                              start_date: start_at, end_date: end_at)

      result = described_class.new('2019-1-1', '2022-1-20').call

      expect(result.first['subsidiary']).to eq 'Paulista'
      expect(result.last['subsidiary']).to eq 'Bela Vista'
      expect(result.first['category']).to eq 'A'
      expect(result.last['category']).to eq 'B'
      expect(result.first['total']).to eq 5
      expect(result.second['total']).to eq 4
      expect(result.third['total']).to eq 3
    end
  end
end