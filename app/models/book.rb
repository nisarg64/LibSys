class Book < ActiveRecord::Base
  validates :isbn, presence: true,uniqueness:true, numericality: {only_integer: true}
  validates :title, presence: true
  validates :description, presence: true
  validates :authors, presence: true
end
