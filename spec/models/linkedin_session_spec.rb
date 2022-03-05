# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinkedinSession, type: :model do
  let!(:linkedin_session) { create(:linkedin_session) }

  it { expect(linkedin_session).to be_valid }
end
