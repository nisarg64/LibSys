class LibraryMembersController < ApplicationController
  before_action :require_admin_login, only: [:index, :destroy]
  before_action :require_member_login, except: [:index, :destroy, :new, :create]

  def new
	@library_member = LibraryMember.new
  end

  def index
    @library_members = LibraryMember.all
  end

  def show
    @library_member = LibraryMember.find(params[:id]);
  end

  def edit
    @library_member = LibraryMember.find(session[:library_member_id]);
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

  def update

    @library_member = LibraryMember.find(session[:library_member_id])
    respond_to do |format|
      if @library_member.update(library_member_params)
        format.html { redirect_to @library_member, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @library_member = LibraryMember.find(params[:id])
    if @library_member.checkout_histories.select{|history| history.return_date.nil?}.size == 0
      @library_member.destroy
      respond_to do |format|
        format.html { redirect_to library_members_path, notice: 'Member was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      flash[:error] = "Cannot delete library member. He/she has book(s) checked out."
      redirect_to library_members_path
    end
  end
  
  def home
  end
  private

    def require_admin_login
      unless admin_logged_in?
        flash[:error] = "Please Log In To View This Page";
        redirect_to admin_login_path;
      end
    end

    def require_member_login
      unless member_logged_in?
        flash[:error] = "Please Log In To View This Page";
        redirect_to member_login_path;
      end
    end

    def library_member_params
      params.require(:library_member).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
