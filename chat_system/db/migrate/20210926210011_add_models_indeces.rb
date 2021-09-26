class AddModelsIndeces < ActiveRecord::Migration[5.2]
  def change
    add_index :applications, :token, unique: true

    add_index :chats, :application_id, unique: true
    add_index :chats, :number, unique: true

    add_index :messages, :chat_id, unique: true
    add_index :messages, :number, unique: true
  end
end
