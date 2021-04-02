class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params) #ログインユーザのコメントをnewする。newするときにbook_comment_paramsの値が入る
    comment.book_id = book.id
    if comment.save
      redirect_to book_path(book)
    else
      @book = book
      @book_comment = comment
      @user = current_user
      render template: "books/show"
    end
  end

  def destroy
    BookComment.find_by(id:params[:id], book_id:params[:book_id]).destroy
    redirect_to book_path(params[:book_id])
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
