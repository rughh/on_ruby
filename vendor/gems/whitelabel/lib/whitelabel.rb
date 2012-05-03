require "whitelabel/version"

require "yaml"

module Whitelabel
  class << self
    attr_accessor :labels

    def from_file(path)
      @labels = File.open(path) { |file| YAML.load(file) }
    end

    def label
      Thread.current[:whitelabel]
    end

    def label=(label)
      Thread.current[:whitelabel] = label
    end

    def label_for(pattern, identifier=:label_id)
      self.label = @labels.find { |label| label.send(identifier) =~ /^#{pattern}$/ }
    end

    def [](accessor)
      self.label.send :"#{accessor}"
    end
  end
end
