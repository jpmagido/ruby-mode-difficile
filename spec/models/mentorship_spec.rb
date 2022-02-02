# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mentorship, type: :model do
  let(:mentorship) { create(:mentorship) }

  it { expect(mentorship).to be_valid }
end
