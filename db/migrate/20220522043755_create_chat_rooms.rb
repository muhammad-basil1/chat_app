class CreateChatRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_rooms do |t|
      t.integer :first_participent_id, index: true, null: false
      t.integer :second_participent_id, index: true, null: false
      t.timestamps
    end
  end
end
