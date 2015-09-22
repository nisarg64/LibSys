class Book < ActiveRecord::Base
  has_many :checkout_histories
  has_many :library_members, through: :checkout_histories
  validates :isbn, presence: true,uniqueness:true, numericality: {only_integer: true}
  validates :title, presence: true
  validates :description, presence: true
  validates :authors, presence: true
end
