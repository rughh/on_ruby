require 'spec_helper'
require 'whitelabel_detection_middleware'

describe WhitelabelDetectionMiddleware do
  subject(:middleware) { described_class.new(dummy_app) }

  let(:dummy_app) { ->(_env) { response } }
  let(:host) { 'localhost' }
  let(:rack_env) { { 'HTTP_HOST' => host } }
  let(:response) { [418, { 'Content-Type' => 'text/plain' }, ['418 No coffee here.']] }

  before { middleware.call(rack_env) }

  {
    'hamburg.onruby.de' => 'hamburg',
    'onruby.eu' => 'hamburg',
    'dresdenrb.onruby.de' => 'dresdenrb',
    'tallinn.ruby.ee' => 'tallinn_rug',
    'www.rug-b.de' => 'berlin',
  }.each do |host, label|
    context "with host '#{host}'" do
      let(:host) { host }

      it "uses Whitelabel '#{label}'" do
        expect(Whitelabel[:label_id]).to eq(label)
      end
    end
  end
end
