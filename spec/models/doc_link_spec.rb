# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DocLink, type: :model do
  let(:doc_link) { create(:doc_link) }

  it { expect(doc_link).to be_valid }
end
