class AddAssociationBetweenChatAndMessage < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :messages, :chats
  end
end