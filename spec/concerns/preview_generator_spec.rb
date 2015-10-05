require "spec_helper"

describe "PreviewGenerator" do

  it "can be created by an URI" do
    g = PreviewGenerator.new('http://google.com')
    expect(g.uri).to eq('http://google.com')
  end

  context "#generate_preview" do

    it "invokes LinkThumbnailer" do
      website = double(videos: [], images: [])
      expect(LinkThumbnailer).to receive(:generate).with('http://hey.com').and_return(website)

      PreviewGenerator.new('http://hey.com').generate_preview
    end

    it "handles bad URIs" do
      expect(LinkThumbnailer).to receive(:generate).and_raise(Net::HTTPServerException.new("", ""))

      expect { PreviewGenerator.new('http://hey.com').generate_preview }.not_to raise_error      
    end

    it "detects the first embeddable video code" do

      embeddable     = double(embed_code: "code")
      non_embeddable = double(embed_code: nil)
      website        = double(videos: [non_embeddable, embeddable], images: [])

      expect(LinkThumbnailer).to receive(:generate).with('http://hey.com').and_return(website)

      pg = PreviewGenerator.new('http://hey.com')

      pg.generate_preview

      expect(pg.video?).to eq(true)
      expect(pg.image?).to eq(false)
      expect(pg.type).to eq(:video)
      expect(pg.code).to eq('code')
    end

    it "uses the first available image" do

      img            = double(src: "src")
      website        = double(videos: [], images: [img])
      expect(LinkThumbnailer).to receive(:generate).with('http://hey.com').and_return(website)

      pg = PreviewGenerator.new('http://hey.com')

      pg.generate_preview

      expect(pg.video?).to eq(false)
      expect(pg.image?).to eq(true)

      expect(pg.type).to eq(:image)
      expect(pg.code).to eq('src')
    end

    it "gives up with no videos nor images" do

      website = double(videos: [], images: [])
      expect(LinkThumbnailer).to receive(:generate).with('http://hey.com').and_return(website)

      pg = PreviewGenerator.new('http://hey.com')

      pg.generate_preview

      expect(pg.video?).to eq(false)
      expect(pg.image?).to eq(false)
      expect(pg.none?).to eq(true)

    end

  end


end

