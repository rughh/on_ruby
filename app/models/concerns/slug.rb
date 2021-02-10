# frozen_string_literal: true

module Slug
  def self.included(clazz)
    def clazz.from_param(token)
      id = if match = token.match(/.*-(\d+)/)
             match[1]
           else
             token
           end

      found = where(id: id.to_i).or(where("#{table_name}.#{slugger} ILIKE ?", token.tr('-', '%'))).first
      raise ActiveRecord::RecordNotFound, "Could not find by slug #{token}" unless found

      found
    end

    def clazz.from_slug(token)
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
    send(self.class.slugger).parameterize
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
