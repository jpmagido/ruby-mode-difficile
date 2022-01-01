require 'rails_helper'

RSpec.describe Session, type: :model do
  let(:session) { build(:session) }
  let!(:saved_session) { create(:session) }

  describe '#save' do
    it 'encodes token attr' do
      session.save!
      expect { Security::EncoderService }.to have_received(:new).with(session[:token])
      expect { Security::EncoderService.new(token: session[:token]) }.to have_received(:encode)
    end
  end

  describe '#token' do
    it 'decodes token attr' do
      saved_session.token
      expect { Security::EncoderService.new(token: session[:token]) }.to have_received(:decode)
    end
  end
end
