class ContactMailer < ApplicationMailer
  default to: ENV.fetch('TO_CONTACT')

  # Email sent to the website administrator
  #
  def send_email(params)
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]

    mail(from: @email, template_path: 'mailers/contacts')
  end

  # Copy of the email send back to the sender
  #
  def copy_email(params)
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]

    mail(from: ENV.fetch('TO_CONTACT'), to: @email, template_path: 'mailers/contacts', template_name: 'send_email')
  end
end
