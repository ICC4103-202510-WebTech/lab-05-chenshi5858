class ChatsController < ApplicationController
  before_action :authenticate_user!
  authorize_resource

  def index
    @chats = Chat.for_user(current_user)
  end

  def show
    @chat = Chat.find(params[:id])
    authorize! :read, @chat
  end

  def new
    @chat = Chat.new
    @users = User.where.not(id: current_user.id)
  end

  def edit
    @chat = Chat.find(params[:id])
    @users = User.where.not(id: current_user.id)
    authorize! :update, @chat
  end

  def update
    @chat = Chat.find(params[:id])
    authorize! :update, @chat
    if @chat.update(chat_params)
      redirect_to chats_path, notice: 'Chat actualizado exitosamente.'
    else
      @users = User.where.not(id: current_user.id)
      flash.now[:alert] = @chat.errors.full_messages.join(", ")
      render :edit
    end
  end

  def create
    @chat = Chat.new(chat_params)
    @chat.sender_id = current_user.id

    if @chat.save
      redirect_to @chat, notice: "Chat was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:receiver_id)
  end
end
