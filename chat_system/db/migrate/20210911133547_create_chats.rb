class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :number
      t.integer :msgs_count

      t.timestamps
    end
  end
end
