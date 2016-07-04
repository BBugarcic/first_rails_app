class MessageMailerPreview < ActionMailer::Preview
  def contact_form
    MessageMailer.contact_form("john@example.com", "John", "Deer", "Hop!")
  end

  def mail_template

  end
end
