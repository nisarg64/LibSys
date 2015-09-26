class SuggestionsController < ApplicationController
  def new
    @suggestion = Suggestion.new
  end

  def create
    @suggestion = Suggestion.new(suggestion_params)
    if @suggestion.save
      flash[:notice] = "You have successfully suggested a book."
      redirect_to suggestion_new_path
    else
      flash[:error] = "An error occured. Please fill out all fields."
      render 'new'
    end
  end

   def add_book
     @suggestion = Suggestion.find(params[:id])
     @book = Book.new(isbn: @suggestion[:isbn], title: @suggestion[:title], description: @suggestion[:description], authors: @suggestion[:authors])
     if @book.save
       flash[:notice] = "You have added a book."
       @suggestion.destroy
       redirect_to suggestions_path
     else
       flash[:error] = "An error occured. Please fill out all fields."
       redirect_to suggestions_path
     end
   end

  def edit
    @suggestion = Suggestion.find(params[:id])
  end

  def update
    @suggestion = Suggestion.find(params[:id])
    if @suggestion.update(suggestion_params)
      redirect_to suggestions_path
    else
      render 'edit'
    end
  end


   def destroy
     @suggestion = Suggestion.find(params[:id])
     @suggestion.destroy
     redirect_to @suggestion
   end


  def index
    @suggestions = Suggestion.all
  end
end

private
def suggestion_params
  params.require(:suggestion).permit(:isbn,:title,:description, :authors)
end