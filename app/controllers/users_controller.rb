class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books.all
    @show_user = current_user
    @book_new = Book.new

  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def index
    @user = User.all
    @new_user = current_user
    @book_new = Book.new
  end

  def update
    @user = User.find(params[:id])

      if @user.update(user_params)
        flash[:notice]="You have updated user successfully."
        redirect_to user_path(current_user)
      else
        render :edit
      end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
