# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Challenge, type: :model do
  let(:challenge) { create(:challenge, title: 'foobar') }

  it { expect(challenge).to be_valid }

  describe '#display_nature' do
    it { expect(challenge.display_nature).to eq 'Challenge : foobar' }
  end

  describe '#type_id' do
    it { expect(challenge.type_id).to eq "Challenge/#{challenge.id}" }
  end
end
