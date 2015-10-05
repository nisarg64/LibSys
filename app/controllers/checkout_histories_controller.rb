class CheckoutHistoriesController < ApplicationController
  before_action :require_login, only: [:checkout]
  before_action :check_legal_user_return_book, only: [:return_book]
  before_action :require_admin, only: [:show_book_history]
  before_action :validate_user_member_history, only: [:show_member_history]

  require 'net/smtp'

  def send_email(to,book_title, opts={})
    opts[:server]      ||= 'localhost'
    opts[:from]        ||= 'ncsuLibrary@RubyExample.com'
    opts[:from_alias]  ||= 'NCSU Ruby Library'
    opts[:subject]     ||= "Your book has been returned"
    opts[:body]        ||= "The book you were waiting for, " + book_title + " , is available."

    msg = <<END_OF_MESSAGE
    From: #{opts[:from_alias]} <#{opts[:from]}>
    To: <#{to}>
    Subject: #{opts[:subject]}

    #{opts[:body]}
END_OF_MESSAGE

    File.write('/log/email.txt', to)
    Net::SMTP.start(opts[:server]) do |smtp|
      smtp.send_message msg, opts[:from], to
    end
  end

  def checkout(member = current_library_member)
    @book = Book.find(params[:id])
    @book.checkout_histories.create(:library_member => member,:issue_date => DateTime.now)
    @book.update(checked_out: true)
    redirect_to @book
  end

  def checkout_admin
    @book = Book.find(params[:id])
    @member = LibraryMember.find_by(params[:library_member])
    if @member.nil?
      flash[:error] = 'No member with such email exists'
      redirect_to @book
    else
      flash[:notice] = "Book Successfully checked out for #{@member.name}"
      checkout(@member)
    end
  end

  def return_book
    @book = Book.find(params[:id])
    @book.checkout_histories.last.update(return_date: DateTime.now)
    @book.update(checked_out: false)
    if Notification.exists?(:bookid => params[:id])
      @notification = Notification.where(:bookid => params[:id])
      @notification.each do |notification|
        if LibraryMember.exists?(:id => notification.userid)
          @member = LibraryMember.find(notification.userid)
          send_email(@member[:email], @book[:title])
       end
        notification.destroy
      end
    end
    flash[:notice] = "Book successfully returned to the library"
    redirect_to @book
  end

  def show_book_history
    @book = Book.find(params[:id])
    @histories = @book.checkout_histories
  end

  def show_member_history
    @member = LibraryMember.find(params[:id])
    @histories = @member.checkout_histories
  end

  private
  def require_login
    unless admin_logged_in? or member_logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to member_login_path
    end
  end

  def check_legal_user_return_book
    require_login
    book = Book.find(params[:id])

    unless member_logged_in? && (book.checkout_histories.last.library_member_id == current_library_member.id) || admin_logged_in?
      flash[:error] = "You do not have permission to return the book"
      redirect_to book
    end
  end

  def require_admin
    unless admin_logged_in?
      flash[:error] = "You do not have sufficient privileges to access this page"
      redirect_to admin_login_path
    end
  end

  def validate_user_member_history
    require_login
    member = LibraryMember.find(params[:id])
    unless admin_logged_in? || member.id == current_library_member.id
      flash[:error] = "You do not have sufficient privileges to access this page"
      redirect_to root_path
    end
  end
end
