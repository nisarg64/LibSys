class AddInitialAdmin < ActiveRecord::Migration
  Admin.create :name=> 'Admin', :email=> 'admin@ncsu.edu', :password => 'admin'
end
