# frozen_string_literal: true

require 'spec_helper'

describe WhitelabelTranslation do
  context '#tw' do
    it 'should translate in scope of a whitelabel' do
      expect(I18n.tw('title')).to eql('Hamburg on Ruby')
    end
  end
end
