module Slug
  def self.included(clazz)
    def clazz.from_param(token)
      id = match = token.match(/.+-(\d+)/) ? match[1] : token
      found = where(id: id.to_i).or(where("#{table_name}.#{slugger} ILIKE ?", token.tr('-', '%'))).first
      unless found
        raise ActiveRecord::RecordNotFound.new("Could not find by slug #{token}")
      end
      found
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

  def as_json(options = {})
    h = super(options)
    h[:slug] = slug
    h
  end
end
