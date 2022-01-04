# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin, type: :model do
  let(:admin) { create(:admin) }

  describe '#initialize' do
    it { expect(admin).to be_valid }
  end
end
