class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :isbn
      t.string  :title
      t.text    :description
      t.text    :authors
      t.boolean :checked_out
      t.timestamps null: false
    end
  end
end
