class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :userid
      t.integer :bookid

      t.timestamps null: false
    end
  end
end
