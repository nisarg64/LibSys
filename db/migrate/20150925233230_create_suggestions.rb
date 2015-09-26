class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.integer :isbn
      t.text :title
      t.text :description
      t.text :authors

      t.timestamps null: false
    end
  end
end
