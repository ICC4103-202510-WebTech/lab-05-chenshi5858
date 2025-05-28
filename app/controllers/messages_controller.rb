class MessagesController < ApplicationController
  before_action :authenticate_user!
  authorize_resource

  def index
    # Mostrar solo mensajes relacionados con los chats del usuario actual
    @messages = Message.joins(:chat)
                       .where("chats.sender_id = ? OR chats.receiver_id = ?", current_user.id, current_user.id)
  end

  def show
    @message = Message.find(params[:id])
    authorize! :read, @message
  end

  def new
    @message = Message.new
    @chats = Chat.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
    @users = User.all
  end

  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    if @message.save
      redirect_to @message, notice: 'Mensaje creado exitosamente.'
    else
      @chats = Chat.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
      flash.now[:alert] = @message.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @message = Message.find(params[:id])
    authorize! :update, @message
    @chats = Chat.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
  end

  def update
    @message = Message.find(params[:id])
    authorize! :update, @message
    if @message.update(message_params)
      redirect_to messages_path, notice: 'Mensaje actualizado exitosamente.'
    else
      @chats = Chat.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
      flash.now[:alert] = @message.errors.full_messages.join(", ")
      render :edit
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :chat_id)
  end
end
