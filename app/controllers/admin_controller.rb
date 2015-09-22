class AdminController < ApplicationController
  before_action :session_valid, :except=>[:welcome]
  before_action only: [:show, :edit, :update, :destroy]


  # GET /admin
  # GET /admin.json
  def index
    puts @logged_admin
    @logged_admin = Admin.find(session[:admin_id]);
  end

  # GET /admin/new
  def new
    @admin = Admin.new
  end

  # GET /admin/1
  # GET /admin/1.json
  def show
    @admin = Admin.find(params[:id]);
  end



  # GET /admin/1/edit
  def edit
    @admin = Admin.find(session[:admin_id]);
  end

  # POST /admin
  # POST /admin.json
  def  welcome
  end

  # POST /admin
  # POST /admin.json
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

  # PATCH/PUT /admin/1
  # PATCH/PUT /admin/1.json
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

  # DELETE /admin/1
  # DELETE /admin/1.json
  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admin_admin_list_path, notice: 'Admin was successfully destroyed.' }
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
      params.require(:admin).permit(:name, :email, :password,
                                             :password_confirmation)
    end
end
