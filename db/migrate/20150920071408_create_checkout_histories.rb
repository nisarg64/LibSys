class CreateCheckoutHistories < ActiveRecord::Migration
  def change
    create_table :checkout_histories do |t|
      t.belongs_to :book, index: true, foreign_key: true
      t.datetime :issue_date
      t.datetime :return_date

      t.timestamps null: false
    end
  end
end
