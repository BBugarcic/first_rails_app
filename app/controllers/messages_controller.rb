class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def thank_you
    @message = Message.new(message_params)

    if @message.save
      @name = @message.name
      @surname = @message.surname
      @email = @message.email
      @content = @message.content
      MessageMailer.contact_form(@email, @name, @surname, @content).deliver_now
    else
      render "new"
    end
  end

private
  def message_params
     params.require(:message).permit(:name, :surname, :email, :content)
   end

end
