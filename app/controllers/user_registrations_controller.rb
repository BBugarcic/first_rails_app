class UserRegistrationsController < Devise::RegistrationsController
  def create
    super
    if @user.persisted?
      MessageMailer.welcome(@user).deliver_now
    end
  end
end
