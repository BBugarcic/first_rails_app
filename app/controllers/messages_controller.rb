class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def thank_you
    @message = Message.new(message_params)

    if @message.save
      @name = @message.name
      @email = @message.email
      @content = @message.content
      MassageMailer.contact_form(@email, @name, @content).deliver_now
    else
      render "new"
    end
  end

private
  def message_params
     params.require(:message).permit(:name, :email, :content)
   end

end
