require 'rails_helper'

describe RentalByCategoryAndSubsidiaryQuery do
  describe '.call' do
    it 'should filter by category' do
      subsidiary = create(:subsidiary, name: 'Vila Mariana')
      other_subsidiary = create(:subsidiary, name: 'Vila Madalena')

      category_a = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                      third_party_insurance: 20)
      category_b = create(:category, name: 'B', daily_rate: 10, car_insurance: 20,
                      third_party_insurance: 20)

      customer = create(:individual_client, name: 'Claudionor',
                    cpf: '318.421.176-43', email: 'cro@email.com')

      create_list(:car, 10, category: category_a)
      create_list(:car, 10, category: category_b)

      create(:rental, category: category_a, subsidiary: subsidiary,
                    start_date: '2019-01-08', end_date: '2019-01-10',
                    client: customer, price_projection: 100, status: :scheduled)
      create(:rental, category: category_a, subsidiary: subsidiary,
                    start_date: '2019-01-02', end_date: '2019-01-09',
                    client: customer, price_projection: 100, status: :scheduled)
      create(:rental, category: category_b, subsidiary: subsidiary,
                    start_date: '2019-02-10', end_date: '2019-02-16',
                    client: customer, price_projection: 100, status: :scheduled)
      create(:rental, category: category_b, subsidiary: subsidiary,
                    start_date: '2018-04-08', end_date: '2018-04-15',
                    client: customer, price_projection: 100, status: :scheduled)

      create(:rental, category: category_a, subsidiary: other_subsidiary,
                    start_date: '2018-06-02', end_date: '2018-06-10',
                    client: customer, price_projection: 100, status: :scheduled)
      create(:rental, category: category_a, subsidiary: other_subsidiary,
                    start_date: '2019-06-05', end_date: '2019-06-09',
                    client: customer, price_projection: 100, status: :scheduled)
      create(:rental, category: category_b, subsidiary: other_subsidiary,
                    start_date: '2019-06-02', end_date: '2019-06-11',
                    client: customer, price_projection: 100, status: :scheduled)
      create(:rental, category: category_b, subsidiary: other_subsidiary,
                    start_date: '2019-07-03', end_date: '2019-07-11',
                    client: customer, price_projection: 100, status: :scheduled)

      start = '2019-01-01'
      finish = '2019-12-01'

      result = described_class.new(start, finish).call
      expect(result.first['subsidiary']).to eq 'Vila Mariana'
      expect(result.first['category']).to eq 'A'
      expect(result.first['total']).to eq 2
      expect(result.last['subsidiary']).to eq 'Vila Madalena'
      expect(result.last['category']).to eq 'A'
      expect(result.last['total']).to eq 1
    end
  end
end
