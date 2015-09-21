class AddIndexToLibraryMembersEmail < ActiveRecord::Migration
  def change
     add_index :library_members, :email, unique: true
  end
end
