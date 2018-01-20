class EmailFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    unless value&.match?(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i)
      record.errors.add(attr_name, :invalid, options.merge(value: value))
    end
  end
end
