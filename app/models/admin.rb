class Admin < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, :presence => true,length: {maximum: 50}
  EMAIL_REGEX = /([A-Z0-9._%+-]+)@([A-Z0-9.-]+)\.[A-Z]{2,4}/i
  validates :email, :presence => true, :uniqueness => true, format: {with: EMAIL_REGEX}
  validates :password, :confirmation => true, length: {minimum: 5}
end
