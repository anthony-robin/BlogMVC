# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  def send_email
    name = 'John Doe'
    email = 'johndoe@example.com'
    message = Faker::Lorem.paragraph(5)

    ContactMailer.send_email(name: name, email: email, message: message)
  end

  def copy_email
    name = 'John Doe'
    email = 'johndoe@example.com'
    message = Faker::Lorem.paragraph(5)

    ContactMailer.copy_email(name: name, email: email, message: message)
  end
end
