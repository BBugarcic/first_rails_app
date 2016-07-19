class MessageMailerPreview < ActionMailer::Preview
  def contact_form
    MessageMailer.contact_form("john@example.com", "John", "Deer", "Hop!")
  end

  def welcome
    user = User.new
    user.email = "b@g.com"
    MessageMailer.welcome(user)
  end
end
