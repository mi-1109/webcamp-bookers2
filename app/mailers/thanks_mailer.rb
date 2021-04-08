class ThanksMailer < ApplicationMailer

  def send_when_signup(email, name) #メソッドに対して引数を設定

    # mailメソッドが呼び出されると、メール本文が記載されているビューが読まれる
    @name = name
    mail to: email, subject: 'Thanks for Joining to Bookers2!' #この行の結果がregistrations_controllerの戻り値として返って、deliverされる
  end
end
