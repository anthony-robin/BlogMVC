require 'reform/form/validation/unique_validator'

class ApplicationForm < Reform::Form
  delegate :new_record?, to: :model
end
