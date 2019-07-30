# typed: false
module ApiHandling
  def expose_api(*fields)
    acts_as_api

    api_accessible :ios_v1 do |template|
      fields.each { |field| template.add field }
    end
  end
end
