class ApplicationController < ActionController::Base
  #devise利用機能が使われる前に、パラメータを実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  #ユーザ登録時にnameのデータ操作を許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
