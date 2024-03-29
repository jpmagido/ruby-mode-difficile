# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'LocalesController', type: :request do
  describe 'PATCH /update' do
    context 'locale is set to english' do
      before do
        VCR.use_cassette('login') { post session_path }
        I18n.locale = :en
      end

      it 'updates app locale to en' do
        expect { patch locale_path(locale: :fr) }.to change(I18n, :locale).from(:en).to(:fr)
      end

      it 'updates current_user language to fr' do
        user = User.last
        user.update!(language: :en)
        patch locale_path(locale: :fr)

        expect(user.reload.language).to eq 'fr'
      end
    end

    context 'locale is set to french' do
      before { I18n.locale = :fr }

      it 'updates app locale to fr' do
        expect { patch locale_path(locale: :en) }.to change(I18n, :locale).from(:fr).to(:en)
      end
    end
  end
end
