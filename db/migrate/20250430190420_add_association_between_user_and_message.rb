class AddAssociationBetweenUserAndMessage < ActiveRecord::Migration[8.0]
  def change
    change_table :messages do |t|
      t.references :user, foreign_key: true unless column_exists?(:messages, :user_id)
      t.references :chat, foreign_key: true unless column_exists?(:messages, :chat_id)
    end
  end
end