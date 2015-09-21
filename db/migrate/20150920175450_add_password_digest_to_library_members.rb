class AddPasswordDigestToLibraryMembers < ActiveRecord::Migration
  def change
    add_column :library_members, :password_digest, :string
  end
end
