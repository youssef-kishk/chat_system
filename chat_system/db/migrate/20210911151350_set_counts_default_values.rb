class SetCountsDefaultValues < ActiveRecord::Migration[5.2]
  def change
    change_column_default :applications, :chats_count, 0
    change_column_default :chats, :msgs_count, 0
  end
end
