class MessageMailer < ApplicationMailer
  default from: "2bjswebdev@gmail.com"

  def contact_form(email, name, surname, content)
    @content = content
    mail(:from => email,
        :to => '2bjswebdev@gmail.com',
        :subject => "A new contact form message from #{name} #{surname}")
  end

  def welcome
    @appname = "Bike Berlin"
    mail(:to => user.email,
        :subject => "Welcome to #{appname}!")
  end
end
