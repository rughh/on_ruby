# frozen_string_literal: true

require 'spec_helper'

describe ApplicationHelper do
  context 'markdown' do
    it 'underlines' do
      expect(helper.markdown('*underline*')).to match('<em>underline</em>')
    end

    it 'autolinks' do
      expect(helper.markdown('auto http://href.org')).to match('auto <a href="http://href.org">http://href.org</a>')
    end

    it 'escapes html tags' do
      expect(helper.markdown('<script>alert("xss");</script>'))
        .to include('&lt;script&gt;alert(&quot;xss&quot;);&lt;/script&gt;')
    end
  end
end
