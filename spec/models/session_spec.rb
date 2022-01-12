# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Session, type: :model do
  let!(:session) { create(:session) }

  it { expect(session).to be_valid }
end
