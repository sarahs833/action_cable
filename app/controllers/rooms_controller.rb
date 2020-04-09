class RoomsController < ApplicationController
  def show
    @messages = Message.all
    @message = Message.new
  end


  def create
    @message = Message.create(params_create)
    if @message.save
      ActionCable.server.broadcast 'chat_channel',
                            content: @message.content
    redirect_to "/"
    end

  end


  private

  def params_create
    params.require(:message).permit(:content)
  end
end
