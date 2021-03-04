class ApplicationController < ActionController::Base
  #devise利用機能が使われる前に、パラメータを実行
  before_action :authenticate_user!,except: [:top, :collection]
  before_action :configure_permitted_parameters, if: :devise_controller?

def after_sign_in_path_for(resource)
  user_path(current_user.id)
end

def after_sign_out_path_for(resource)
  root_path
end

  protected

  #ユーザ登録時にnameとemailのデータ操作を許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

end
