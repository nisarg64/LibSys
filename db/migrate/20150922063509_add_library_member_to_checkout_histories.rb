  class AddLibraryMemberToCheckoutHistories < ActiveRecord::Migration
    def change
      change_table :checkout_histories do |t|
        t.belongs_to :library_member, index: true, foreign_key: true
      end
    end
  end
