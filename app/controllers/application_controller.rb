class ApplicationController < ActionController::Base

  # deviseのコントローラーに修正が必要な際にここに記載する
    #deviseを利用する機能が実行される前に「configure〜」が実行される
    before_action :configure_permitted_parameters, if: :devise_controller?

    #ログイン認証後のリダイレクト先
    def after_sign_in_path_for(resource)
      user_path(current_user.id)
    end

    #ストロングパラメータ

    #protected・・・呼び出された他のコントローラーからも参照できる
    protected

    #デフォルトで用意されていないカラム(name)を追加したため修正
    #deviseがユーザー名を受け付けるように
    def configure_permitted_parameters
      # devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end

end
