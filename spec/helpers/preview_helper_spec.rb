require 'spec_helper'

describe PreviewHelper do
  describe '#material_preview' do
    it 'generates nothing if the material has no preview' do
      material = build(:material)
      expect(helper.material_preview(material)).to eql('')
    end

    it 'generates nothing if the material has a preview of type :none' do
      material = build(:material, preview_type: 'none')
      expect(helper.material_preview(material)).to eql('')
    end

    it 'generates code for videos' do
      material = build(:material, preview_type: 'video', preview_code: 'embed code')
      expect(helper.material_preview(material)).to eql('<div class="preview video">embed code</div>')
    end

    it 'generates code for images' do
      material = build(:material, name: 'hello', url: 'url', preview_type: 'image', preview_code: 'http://a.png')
      expect(helper.material_preview(material)).to eql('<div class="preview image"><a title="hello" href="url"><img alt="hello" src="http://a.png" /></a></div>')
    end
  end
end
