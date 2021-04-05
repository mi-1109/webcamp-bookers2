class Users::RegistrationsController < Devise::RegistrationsController #deviseの該当クラスを継承

  def create
    super do  # 他はdeviseの機能をそのまま流用する
      if @user.save
        ThanksMailer.send_when_signup(@user).delivery_method
        redirect_to @user
      else
        render 'new'
    end
  end

end