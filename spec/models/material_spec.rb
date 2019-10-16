require 'spec_helper'

describe Material do
  context 'validate url' do
    subject (:create_material) { create(:material, url: url) }

    context 'with a blank url' do
      let (:url) { nil }

      it 'raises validataion error' do
        expect { create_material }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'with a valid url' do
      let (:url) { 'https://google.com' }

      it 'creates the record' do
        expect { create_material }.to change(Material, :count).by(1)
      end
    end

    context 'with a invalid url' do
      let (:url) { 'https/google.invalid' }

      it 'raises validataion error' do
        expect { create_material }.to raise_error ActiveRecord::RecordInvalid
      end
    end
  end

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
