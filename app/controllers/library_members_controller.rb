class LibraryMembersController < ApplicationController
  def new
	@library_member = LibraryMember.new
  end

  def index
    @library_members = LibraryMember.all
  end
  
  def create
    @library_member = LibraryMember.new(library_member_params)
    if @library_member.save
	  log_in_member @library_member
      redirect_to @library_member
    else
      render 'new'
    end
  end

  def destroy
    @library_member = LibraryMember.find(params[:id])
    @library_member.destroy
    respond_to do |format|
      format.html { redirect_to library_members_path, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def home
  end
  private

    def library_member_params
      params.require(:library_member).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
