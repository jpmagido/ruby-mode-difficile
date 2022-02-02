require 'rails_helper'

RSpec.describe Coach, type: :model do
  let(:coach) { create(:coach) }

  it { expect(coach).to be_valid }
end
