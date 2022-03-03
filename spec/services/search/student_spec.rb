# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Search::Student, type: :service do
  let(:search_student) { described_class.new(Student.all, {}) }

  it { expect { search_student }.not_to raise_error }
  it { expect(search_student.search).to be_an ActiveRecord::Relation }

  context 'Search with parameters' do
    let!(:answer) { create(:answer, user: user) }
    let!(:mentorship) { create(:mentorship, student: student) }
    let(:user) { create(:user, login: 'Leopold') }
    let(:student) { create(:student, user: user) }
    let(:wrong_student) { create(:student) }

    let(:search) { described_class.new(Student.all, params) }
    let(:params) { { name: 'Leopold', answer_count_min: 1, answer_count_max: 1, has_coach: true, language: 'fr' } }

    it 'includes proper Students' do
      expect(search.search).to include(student)
      expect(search.search).not_to include(wrong_student)
    end
  end
end
