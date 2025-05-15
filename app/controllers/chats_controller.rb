class ChatsController < ApplicationController
  def index
    @chats = Chat.all
  end

  def show
    @chat = Chat.find(params[:id])
  end

  def new
    @chat = Chat.new
    @users = User.all
  end

  def edit
    @chat = Chat.find(params[:id])
    @users = User.all
  end

  def update
    @chat = Chat.find(params[:id])
    if @chat.update(chat_params)
      redirect_to chats_path, notice: 'Chat was successfully updated.'
    else
      @users = User.all
      flash.now[:alert] = @chat.errors.full_messages.join(", ")
      render :edit
    end
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      redirect_to @chat, notice: 'Chat was successfully created.'
    else
      @users = User.all
      flash.now[:alert] = @chat.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:sender_id, :receiver_id)
  end
end
