class SessionsController < ApplicationController
  def new_member
  end

  def create_member
    if admin_logged_in? || member_logged_in?
      log_out
    end
    library_member = LibraryMember.find_by(email: params[:session][:email].downcase)
    if library_member && library_member.authenticate(params[:session][:password])
      log_in_member library_member
      redirect_to root_path
    else
	  flash.now[:danger] = 'Invalid email/password combination' 
      render 'new_member'
    end
  end
  
  def new_admin
  end

  def create_admin
    if admin_logged_in? || member_logged_in?
      log_out
    end
    admin = Admin.find_by(email: params[:session][:email].downcase)
    logger.info "admin"
    if admin && admin.authenticate(params[:session][:password])
      session[:admin_id]=admin.id
      session[:role]='Administrator'
      redirect_to root_path
    else
      flash.now[:error] = 'Invalid Login Credentials'
      render 'new_admin'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
