# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:student) { create(:student) }

  it { expect(student).to be_valid }
end
