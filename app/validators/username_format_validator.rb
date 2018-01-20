class UsernameFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    unless value&.match?(/\A[a-z0-9 _\-\.]*\z/i)
      record.errors.add(attr_name, :invalid, options.merge(value: value))
    end
  end
end
