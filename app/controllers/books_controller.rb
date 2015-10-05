class BooksController < ApplicationController
  before_action :require_login
  before_action :require_admin_login, except: [:show, :index, :search, :add_notification]

  def index
    @books = Book.all
    @search_params = {:keyword=>'',:checked_out=>'all'}
  end

  def show
    @book = Book.find(params[:id])
  end

  def search
    key= params[:search][:keyword]
    unfiltered_books = Book.lookup(key)
    @books = unfiltered_books
    unless params[:search][:checked_out] == "all"
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
      flash[:success]="Book details were successfully updated"
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.checked_out?
      flash[:error] = "Cannot delete book. Book is currently checked out by a library member."
    else
      Notification.delete_all(["bookid = ?", params[:id]])
      @book.destroy
    end
    redirect_to books_path
  end


  def add_notification
    if Notification.find_by(:userid => current_library_member.id,:bookid => params[:id]) == nil
      @notification = Notification.new(:userid => current_library_member.id,:bookid => params[:id])
      if @notification.save
        flash[:notice] = "You will recieve a notification when this book is available."
        redirect_to (:back)
      else
        flash[:error] = "Cannot save notification."
      end
    else
      flash[:notice] = "You have already signed up for a notification for this book."
      redirect_to (:back)
    end
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
