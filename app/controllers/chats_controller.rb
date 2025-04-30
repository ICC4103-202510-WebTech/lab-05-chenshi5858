class ChatsController<ApplicationController
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

    def create
        @chat = Chat.new(chat_params)
        if @chat.save
          redirect_to @chat, notice: 'Chat was successfully created.'
        else
          @users = User.all
          render :new
        end
    end

    private

    def chat_params
        params.require(:chat).permit(:sender_id, :receiver_id)
    end
end