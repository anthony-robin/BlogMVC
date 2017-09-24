require 'codacy-coverage'

if ENV['COVERAGE']
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
    [
      SimpleCov::Formatter::HTMLFormatter,
      Codacy::Formatter
    ]
  )

  SimpleCov.start 'rails' do
    add_filter 'app/channels/'

    add_group 'Forms', 'app/forms/'
    add_group 'Serializers', 'app/serializers/'
    add_group 'Uploaders', 'app/uploaders/'
    add_group 'Libraries', 'app/validators/'
  end
end
