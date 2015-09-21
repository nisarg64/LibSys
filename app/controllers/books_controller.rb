class BooksController < ApplicationController
  before_action :require_admin_login, except: [:show, :search]
  before_action :require_member_login
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def search

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

  def require_member_login
    unless member_logged_in?
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
