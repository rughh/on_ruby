require 'spec_helper'

describe UserMailer do
  describe '#login_link' do
    subject(:mail) do
      described_class.login_link(email, token, from, locale, label_name, label_link).deliver_now
    end

    let(:email) { 'user@example.com' }
    let(:token) { '12345678' }
    let(:from) { 'no-reply@example.com' }
    let(:locale) { :en }
    let(:label_name) { 'My RUG' }
    let(:label_link) { 'http://rug.org' }

    it 'renders the headers' do
      expect(mail.subject).to eq('Login to My RUG')
      expect(mail.to).to eq([email])
      expect(mail.from).to eq([from])
    end

    it 'renders the body' do
      link = provider_callback_url(provider: :email,
                                   token:, host: label_link)

      expect(mail.body.encoded).to include(link)
      expect(mail.body.encoded).to include(label_name)
      expect(mail.body.encoded).to include(label_link)
    end

    context 'when using different locale' do
      let(:locale) { :es }

      it 'uses the correct locale for the subject' do
        expect(mail.subject).to eq('Accede a My RUG')
      end
    end
  end
end
