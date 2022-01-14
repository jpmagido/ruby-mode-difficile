require 'rails_helper'

RSpec.describe Doc, type: :model do
  let(:doc) { create(:doc) }

  it { expect(doc).to be_valid }
end
