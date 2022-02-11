# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimeSlot, type: :model do
  let(:time_slot) { create(:time_slot) }

  it { expect(time_slot).to be_valid }
end
