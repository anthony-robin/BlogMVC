class ContactMailer < ApplicationMailer
  # Email sent to the website administrator
  #
  # @param params [Hash] mailer values
  # @option params [String] :name name of sender
  # @option params [String] :email email of sender
  # @option params [String] :message contact message
  def send_email(params)
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]

    mail from: @email
  end

  # Copy of the email send back to the sender
  #
  # @param params [Hash] mailer values
  # @option params [String] :name name of sender
  # @option params [String] :email email of sender
  # @option params [String] :message contact message
  def copy_email(params)
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]

    mail from: ENV.fetch('WEBMASTER_EMAIL'),
         to: @email,
         template_name: 'send_email'
  end
end
