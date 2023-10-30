class BooksController < ApplicationController
  before_action :is_user_current
before_action :is_user_creater,only: [:edit,:update]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "投稿しました"
    redirect_to book_path(@book.id)
  else
    @books = Book.all
    @user = current_user
    render :index
    @book = Book.new
  end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = current_user
    @comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "本の情報を更新しました"
    redirect_to book_path(@book.id)
  else
    render :edit
  end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "本を削除しました"
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

  def is_user_current
    unless user_signed_in?
      redirect_to new_user_session_path
    end
   end

  def is_user_creater
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end

end
