class UsersController < ApplicationController

  before_action :authenticate_user!

  before_action :correct_user, only: [:edit, :update]


  def show
    # ユーザーのデータを1件取得し、インスタンス変数へ渡す
    @user = User.find(params[:id])
    @book = Book.new
    # @books =Book.all

    #個人が投稿したものだけ表示(ページング　kaminari)
    @books = @user.books.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])

  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "successfully updated."  #成功メッセージを代入
      redirect_to user_path(@user.id)
    else
      flash[:notice] = "error updated."
      #エラーの場合は表示させるだけなのでrender(処理がいらない)
      render ("users/edit")  #失敗の場合
    end
  end

  def index
    @users = User.all

    #部分テンプレート用
    # @user = User.find(params[:id])
    @book = Book.new
  end


  private

    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end

    #URLに直接入力で編集を防ぐ
    def correct_user
      @user = User.find(params[:id])
      if current_user.id != @user.id
        redirect_to user_path(current_user)  #マイページに飛ばす
      end
    end

end
