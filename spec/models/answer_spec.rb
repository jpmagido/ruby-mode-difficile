# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:answer) { create(:answer) }

  describe '#initialize' do
    it { expect(answer).to be_valid }
  end
end
