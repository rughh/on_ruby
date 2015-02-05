require 'spec_helper'

describe Material do

  context '#generate_preview' do
    it 'uses the PreviewGenerator' do
      material = create(:material, url: 'http://hey.com')

      generator = double(type: 'image', code: 'code')
      expect(PreviewGenerator).to receive(:new).with('http://hey.com').and_return(generator)
      expect(generator).to receive(:generate_preview)
      expect(material).to receive(:save)

      material.generate_preview

      expect(material.preview_type).to eq('image')
      expect(material.preview_code).to eq('code')
    end
  end
end
