require 'rails_helper'

describe RentalPresenter do
  describe '#status' do
    it 'should render primary badge' do
      user = create(:user)
      rental = build(:rental, status: :scheduled)
      result = RentalPresenter.new(rental, user).status_badge
      expect(result).to eq('<span class="badge badge-primary">agendada</span>')
    end
  end

  describe '#current_action' do
    include Rails.application.routes.url_helpers
    context 'authenticate user' do
      it 'should return start rental' do
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
                        status: :scheduled)
        result = RentalPresenter.new(rental, user).current_action

        expect(result).to eq("<a href=\"/rentals/1/review\">Iniciar Locação</a>")
      end

      it 'should return closure rental' do
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
                        status: :ongoing)
        result = RentalPresenter.new(rental, user).current_action

        expect(result).to eq("<a href=\"/rentals/1/closure_review\">Encerrar Locação</a>")
      end

      it 'should return continue rental' do
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
                        status: :in_review)
        result = RentalPresenter.new(rental, user).current_action

        expect(result).to eq("<a href=\"/rentals/1/review\">Continuar Locação</a>")
      end

      it 'should return report rental' do
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
        result = RentalPresenter.new(rental, user).current_action

        expect(result).to eq("<a href=\"/rentals/1/report\">Reportar Problema</a>")
      end

      it 'should not return report rental' do
        subsidiary = create(:subsidiary, name: 'Almeida Motors')
        user = create(:user, role: :user)
        category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                          third_party_insurance: 20)
        car_model = create(:car_model, name: 'Sedan',
                          category: category)
        car = create(:car, car_model: car_model, license_plate: 'TAT-1234',
                    subsidiary: subsidiary)
        rental = create(:rental, category: category, subsidiary: subsidiary,
                        start_date: '3000-01-08', end_date: '3000-01-10',
                        status: :finalized)
        result = RentalPresenter.new(rental, user).current_action

        expect(result).to eq("")
      end
    end

    context 'nil user' do
      it 'should not return rental action' do
        subsidiary = create(:subsidiary, name: 'Almeida Motors')
        category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                          third_party_insurance: 20)
        car_model = create(:car_model, name: 'Sedan',
                          category: category)
        car = create(:car, car_model: car_model, license_plate: 'TAT-1234',
                    subsidiary: subsidiary)
        rental = create(:rental, category: category, subsidiary: subsidiary,
                        start_date: '3000-01-08', end_date: '3000-01-10',
                        status: :scheduled)
        result = RentalPresenter.new(rental, nil).current_action

        expect(result).to eq("")
      end
    end
  end
end
