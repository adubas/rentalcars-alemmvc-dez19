require 'rails_helper'

describe CarModelDecorator do
  describe '#car_options' do
    it 'should return an array' do
      car_model = build(:car_model, car_options: 'ar condicionado, teto solar, car play')

      result = car_model.decorate.car_options

      expect(result).to match(['ar condicionado', 'teto solar', 'car play'])
    end
  end
end