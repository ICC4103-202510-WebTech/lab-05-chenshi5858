class CreateTableMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.integer :chat_id
      t.integer :user_id
      t.text :body
      
      t.timestamps
    end
  end
end
