class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.integer :chat_room_id, index: true
      t.integer :sender_id, index: true
      t.text :body
      t.timestamps
    end
  end
end
