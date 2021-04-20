require 'spec_helper'

describe WhitelabelTranslation do
  describe '#tw' do
    it 'translates in scope of a whitelabel' do
      expect(I18n.tw('title')).to eql('Hamburg on Ruby')
    end
  end
end
