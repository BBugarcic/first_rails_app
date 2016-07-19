class UserRegistrationsController < Devise::RegistrationsController
  def create
    super
    if @user.persisted?
      MessageMailer.welcome.deliver_now
    end
  end
end
