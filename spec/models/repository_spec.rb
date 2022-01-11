require 'rails_helper'

RSpec.describe Repository, type: :model do
  let(:repository) { create(:repository) }

  it { expect(repository).to be_valid }
end
