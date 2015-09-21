class SessionsController < ApplicationController
  def new_member
  end

  def create_member
    library_member = LibraryMember.find_by(email: params[:session][:email].downcase)
    if library_member && library_member.authenticate(params[:session][:password])
      log_in_member library_member
      redirect_to root_url
    else
	  flash.now[:danger] = 'Invalid email/password combination' 
      render 'new_member'
    end
  end
  
  def new_admin
  end

  def create_admin
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
