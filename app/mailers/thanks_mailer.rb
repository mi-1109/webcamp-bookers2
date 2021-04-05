class ThanksMailer < ApplicationMailer

  def send_when_signup(user, contact) #メソッドに対して引数を設定
    @user = user #ユーザー情報
    mail to: user.email, subject: 'Thanks for Joining to Bookers2!'
  end
end
