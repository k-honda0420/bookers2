class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @show_user = current_user
    @book_new = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @show_user = current_user
    @book_new = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
        render "edit"
    else
        redirect_to books_path
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice]="Book was successfully destroyed."
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
      if @book.update(book_params)
        flash[:notice]="Book was successfully updated."
        redirect_to book_path(@book.id)
      else
        render :edit
      end
  end
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
      if @book.save
        flash[:notice]="You have created book successfully."
       redirect_to book_path(@book)
      else
        @show_user = current_user
        @books = Book.all
        render :index 
      end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
