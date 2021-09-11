class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.text :token
      t.integer :chats_count

      t.timestamps
    end
  end
end
