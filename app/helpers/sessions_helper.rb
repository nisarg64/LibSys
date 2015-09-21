module SessionsHelper

  # Logs in the given member.
  def log_in_member(library_member)
    session[:library_member_id] = library_member.id
  end
  
  # Returns the current logged-in member (if any).
  def current_library_member
    @library_member ||= LibraryMember.find_by(id: session[:library_member_id])
  end
  
  # Returns the current logged-in admin (if any).
  def current_admin
    #@library_member ||= LibraryMember.find_by(id: session[:library_member_id])
  end
  
  # Returns true if the user is logged in, false otherwise.
  def member_logged_in?
    !current_library_member.nil?
  end
  
  def admin_logged_in?
	false
  end

  def log_out
    if LibraryMember.find(session[:library_member_id])
		session.delete(:library_member_id)
        @current_library_member = nil
	else 
		session.delete(:admin_member_id)
        @current_admin = nil
	end
  end
end