class SessionsController < ApplicationController
  def new
  end

  def create
    admin = Admin.find_by(email: params[:session][:email].downcase)
    print(admin)
    if admin && admin.password == params[:session][:password]
      session[:admin_id]=admin.id
      session[:role]='Administrator'
      redirect_to controller: 'Admin', action: 'index'
    else
      flash.now[:error] = 'Invalid Login Credentials'
      render 'new'
    end
  end

  def destroy
    session.destroy;
    flash.now[:notice] = 'You Have Been Logged Out Successfully'
    render 'admin/welcome'
  end


end
