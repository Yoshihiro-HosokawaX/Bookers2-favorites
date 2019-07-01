class BooksController < ApplicationController

    # ログイン認証しないと実行できないアクション一覧
    before_action :authenticate_user!, only: [:new, :show, :index, 
            :create, :edit, :create, :update, :destroy]

    before_action :correct_user, only: [:edit, :update, :destroy]


    def home
    end

    def about
    end

    def new
        @book = Book.new(book_params)
    end

    def show
        @book = Book.find(params[:id])

    end



    # book ローカル変数(アクション内でしか利用できない)
    def create
        book = Book.new(book_params)

        #bookの「user_id」のカラムにcreate時にuserのidを代入する
        book.user_id = current_user.id

        if book.save
            flash[:notice] = "Book was successfully created."  #成功メッセージを代入
            redirect_to book_path(book.id)  #投稿したshowのページにリダイレクト
        else
            #validatesを失敗したとき
            flash[:notice] = "error created."
            redirect_to books_path
        end
    end

    # 一覧
    def index
        # 記事を全件取得
        @books = Book.all
         # 新規データ登録用に生成
        @book = Book.new

        @users = User.all

        #ログインユーザー以外のユーザーのマイページを表示するための
        # @user = User.find(params[@book.user_id])

    end

    def edit
        @book = Book.find(params[:id])
    end

    def update
        book = Book.find(params[:id])
        book.update(book_params)
        if book.update(book_params)
            flash[:notice] = "Book was successfully updated."  #成功メッセージを代入
            redirect_to book_path(book.id)  #showのページにリダイレクト
        else
            flash[:notice] = "error updated."
            redirect_to book_path   #ブック一覧に飛ばす
        end
    end

    def destroy
        book = Book.find(params[:id])
        book.destroy
        if book.destroy
            flash[:notice] = "Book was successfully destroyed."  #成功メッセージを代入
            redirect_to books_path  #indexのページにリダイレクト
        else
            flash[:notice] = "error destroyed."
            redirect_to user_path
        end
    end


    # ストロングパラメーター(メソッド名は「モデル名_paramsが多い)
    private
        def book_params
            params.require(:book).permit(:title, :body)
        end

         #URLに直接入力で編集を防ぐ
        def correct_user
            book = Book.find(params[:id])
            if current_user.id != book.user.id
                redirect_to books_path  #ブック一覧に飛ばす
            end
        end
end
