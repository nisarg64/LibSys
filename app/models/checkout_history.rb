class CheckoutHistory < ActiveRecord::Base
  belongs_to :book
  belongs_to :library_member
end
