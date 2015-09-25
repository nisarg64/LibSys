class BooksController < ApplicationController
  before_action :require_login
  before_action :require_admin_login, except: [:show, :index, :search]

  def index
    @books = Book.all
    @search_params = {:keyword=>"",:checked_out=>"false"}
  end

  def show
    @book = Book.find(params[:id])
  end

  def search
    key= params[:search][:keyword]
    unfiltered_books = Book.lookup(key)
    unless params[:search][:keyword] == "all"
      @books = unfiltered_books.select {|b| b.checked_out.to_s == params[:search][:checked_out]}
    end
    @search_params = {}
    @search_params[:keyword] = params[:search][:keyword]
    @search_params[:checked_out] = params[:search][:checked_out]
    render 'index'
  end

  def new
  @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.checked_out = false
    if @book.save
      redirect_to @book
    else
      render 'new'
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:isbn,:title,:description, :authors)
  end

  def require_login
    unless member_logged_in? || admin_logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to member_login_path
    end
  end

  def require_admin_login
    unless admin_logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to admin_login_path
    end
  end
end
