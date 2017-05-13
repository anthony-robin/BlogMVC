class ApplicationMailer < ActionMailer::Base
  helper ApplicationHelper

  layout 'mailer'
  default from: 'from@example.com'
end
