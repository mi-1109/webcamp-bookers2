class Users::RegistrationsController < Devise::RegistrationsController #deviseの該当クラスを継承

  def create
    super # 他はdeviseの機能をそのまま流用する
    ThanksMailer.send_when_signup(params[:user][:email],params[:user][:name]).deliver #deliverメソッドで確認メールを送信
  end
end
