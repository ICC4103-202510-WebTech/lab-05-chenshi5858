class RenameTableMessagesToMessages < ActiveRecord::Migration[6.0]
  def change
    rename_table :table_messages, :messages
  end
end