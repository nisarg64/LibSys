require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    @controller = SessionsController.new
  end


  test "should get new member" do
     get :new_member
     assert_response :success
  end

  test "should get new admin" do
    get :new_admin
    assert_response :success
  end


  test "should create admin session" do
     patch :create_admin, params ,   session: { }
     assert_response(:success)
  end


  test "should create library member session" do
    patch :create_member, params ,   session: { }
    assert_response(:success)
  end


  test "should destroy session" do
    delete :destroy
    assert_redirected_to root_path
  end



  def params
    {:session => { :email => "Example@gmail.com",:password =>"password" }}
  end
end
