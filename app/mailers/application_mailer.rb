class ApplicationMailer < ActionMailer::Base
  helper ApplicationHelper

  layout 'mailer'
  default from: ENV.fetch('WEBMASTER_EMAIL')
  default to: ENV.fetch('WEBMASTER_EMAIL')
end
