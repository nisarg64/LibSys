class AdminController < ApplicationController
  before_action :session_valid, :except=>[:welcome]

  def index
    @logged_admin = Admin.find(session[:admin_id]);
  end

  def new
    @admin = Admin.new
  end

  def show
    @admin = Admin.find(params[:id]);
  end

  def edit
    @admin = Admin.find(session[:admin_id]);
  end

  # POST /admins
  # POST /admins.json
  def  welcome

  end

  def create
    @admin = Admin.new(admin_params)
    respond_to do |format|
      if @admin.save
        format.html { redirect_to @admin, notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @admin = Admin.find(session[:admin_id])
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admin_admin_list_path, notice: 'Administrator was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def admin_list
    @admins = Admin.all
  end




  private
  # Use callbacks to share common setup or constraints between actions.

  def session_valid
    if (session[:admin_id]==nil && session[:role]!='Administrator')
      flash[:notice] = "Please Log In To View This Page";
      redirect_to signin_path;
    end
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_params
    params.require(:admin).permit(:name, :email, :password, :password_confirmation)
  end
end
