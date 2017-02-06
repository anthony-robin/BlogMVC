class UsernameFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    record.errors.add(attr_name, :invalid, options.merge(value: value)) unless value =~ /\A[a-z0-9 _\-\.]*\z/i
  end
end
