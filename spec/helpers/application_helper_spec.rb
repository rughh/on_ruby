require "spec_helper"

describe ApplicationHelper do
  context "render_cached" do
    before { allow(helper).to receive_messages(action_name: 'test') }

    it "caches a scoped key" do
      allow(helper).to receive(:cache).with("hamburg/de/test/test", {expires_in: 14400, skip_digest: true})

      helper.render_cached
    end

    it "caches passed keys" do
      allow(helper).to receive(:cache).with("hamburg/de/hallo/klaus", {expires_in: 14400, skip_digest: true})

      helper.render_cached(:hallo, :klaus)
    end
  end

  context "markdown" do
    it "underlines" do
      expect(helper.markdown("*underline*")).to match("<em>underline</em>")
    end

    it "autolinks" do
      expect(helper.markdown("auto http://href.org")).to match("auto <a href=\"http://href.org\">http://href.org</a>")
    end
  end
end
