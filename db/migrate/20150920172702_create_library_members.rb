class CreateLibraryMembers < ActiveRecord::Migration
  def change
    create_table :library_members do |t|
      t.string :name
      t.string :email

      t.timestamps null: true
    end
  end
end
