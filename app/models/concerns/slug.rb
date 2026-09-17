# frozen_string_literal: true

module Slug
  PARAM_ENDS_IN_DIGITS = /-(\d+)\z/

  def self.included(clazz)
    def clazz.from_param(token)
      match = token.match(PARAM_ENDS_IN_DIGITS).try(:[], 1) || token.to_i
      raise ActiveRecord::RecordNotFound, "Could not find by slug #{token}" unless match

      find(match)
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
