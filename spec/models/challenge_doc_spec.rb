# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChallengeDoc, type: :model do
  let(:challenge_doc) { create(:challenge_doc) }

  it { expect(challenge_doc).to be_valid }
end
