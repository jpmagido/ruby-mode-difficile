require 'rails_helper'

RSpec.describe Challenge, type: :model do
  let(:challenge) { build(:challenge) }

  it { expect(challenge).to be_valid }
end
