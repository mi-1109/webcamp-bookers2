class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params) #ログインユーザのコメントをnewする。newするときにbook_comment_paramsの値が入る
    @book_comment.book_id = @book.id #@book_comment（コメント新投稿）のコメント投稿先のbook_idは、@bookで取得したbook_id
    @book_comment.save
    @user = current_user
  end

  def destroy
    @book = Book.find(params[:book_id])
    BookComment.find_by(id:params[:id], book_id:params[:book_id]).destroy
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
