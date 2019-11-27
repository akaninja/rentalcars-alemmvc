require 'rails_helper'

describe NilUser do
  # subject { described_class.new }

  context '#email' do
    it { expect(subject.email).to eq '' }
  end

  context '#admin?' do
    it { expect(subject.admin?).to eq false }
  end

  context '#user?' do
    it { expect(subject.user?).to eq false }
  end
end
