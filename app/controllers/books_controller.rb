class BooksController < ApplicationController

  before_action :correct_user, only:[:edit, :update, :destroy]

  def create
    @book = Book.new(book_params)
    @user = User.find(@book.user_id)
    if @book.save
      redirect_to book_path(@book.id), notice: "successfully registered your post!"
    else
      @books = Book.all
      render action: :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.new
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @newbook = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "successfully updated your post!"
    else
      render action: :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body) .merge(user_id: current_user.id)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    redirect_to books_path unless @user == current_user
  end
end
