class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
    @chats = Chat.all
    @users = User.all
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to @message, notice: 'Message was successfully created.'
    else
      @chats = Chat.all
      @users = User.all
      flash.now[:alert] = @message.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @message = Message.find(params[:id])
    @chats = Chat.all
    @users = User.all
  end

  def update
    @message = Message.find(params[:id])
    if @message.update(message_params)
      redirect_to messages_path, notice: 'Message was successfully updated.'
    else
      @chats = Chat.all
      @users = User.all
      flash.now[:alert] = @message.errors.full_messages.join(", ")
      render :edit
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id, :chat_id)
  end
end
