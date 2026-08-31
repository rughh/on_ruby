# Small replacement for the `errors_on` matcher that rspec-collection_matchers
# used to provide. Runs the validations and returns the messages for one
# attribute, so specs can assert on their count.
module ValidationHelper
  def errors_on(record, attribute)
    record.valid?
    record.errors[attribute]
  end
end
