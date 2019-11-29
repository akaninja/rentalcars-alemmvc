require 'rails_helper'

describe CancelScheduledRentalsJob do
  describe '.auto_enqueue' do
    it 'should auto enqueue' do
      described_class.auto_enqueue(Time.zone.now)
      expect(Delayed::Worker.new.work_off).to eq [1,0]
    end
  end
end
