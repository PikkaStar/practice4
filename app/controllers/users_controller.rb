class UsersController < ApplicationController
  before_action :is_user_current
  before_action :is_user_creater,only: [:edit,:update]

  def index
    @book = Book.new
    @users = User.all
    @user = current_user
  end

  def show
     @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  private
  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end

   def is_user_current
    unless user_signed_in?
      redirect_to new_user_session_path
    end
   end

  def is_user_creater
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

end
