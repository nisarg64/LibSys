class Book < ActiveRecord::Base
  has_many :checkout_histories, dependent: :destroy
  has_many :library_members, through: :checkout_histories
  validates :isbn, presence: true,uniqueness:true, numericality: {only_integer: true}
  validates :title, presence: true
  validates :description, presence: true
  validates :authors, presence: true
end

def Book.lookup(keyword)
  Book.where("isbn = ? OR title LIKE ? OR description LIKE ? OR authors LIKE ?",keyword,"%#{keyword}%","%#{keyword}%","%#{keyword}%")
end
