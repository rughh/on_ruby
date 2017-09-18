module Slug
  def self.included(clazz)
    def clazz.from_param(token)
      id = if match = token.match(/.+-(\d+)/)
        match[1]
      else
        token
      end

      find(id)
    end

    def clazz.find_by_slug(token)
      from_param(token)
    end

    def clazz.slugged_by(column)
      @slugger = column
    end

    def clazz.slugger
      @slugger || :name
    end
  end

  def slug
    self.send(self.class.slugger).parameterize
  end

  def to_param
    "#{slug}-#{id}"
  end
end
