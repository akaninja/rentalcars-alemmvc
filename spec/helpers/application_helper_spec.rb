require 'rails_helper'

describe ApplicationHelper do
  describe '#rental_status' do
    it 'should render green color when finalized' do
      rental = build(:rental, status: :finalized)

      result = helper.rental_status(rental)

      expect(result).to eq('<span class="badge badge-finalized">finalizada'\
                           '</span>')
    end

    it 'should render blue color when ongoing' do
      rental = build(:rental, status: :ongoing)

      result = helper.rental_status(rental)

      expect(result).to eq('<span class="badge badge-ongoing">em andamento'\
                           '</span>')
    end
  end
end
