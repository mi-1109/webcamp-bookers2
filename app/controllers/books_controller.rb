class BooksController < ApplicationController

  def create
    book = Book.new(book_params)
    book.save
    redirect_to books_path
  end

  def index
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.new
  end

  def edit
  end

  def destroy
  end

  private

  def book_params
    params.require(:book).permit(:title, :body) .merge(user_id: current_user.id)
  end
end
