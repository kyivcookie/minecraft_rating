class ContactMailer < ActionMailer::Base
  default from: 'info@minecraftservers-ip.com'

  def contact_email(name, email, message)
    @name = name
    @email = email
    @message = message

    mail(to: 'support@mincraftservers-ip.com', subject: 'You have new message from contact_mailer form')
  end
end
