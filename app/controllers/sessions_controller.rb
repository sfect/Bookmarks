class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "ログインしました。"
      redirect_to root_path
    else
      flash[:error] = "ユーザー名またはパスワードが正しくありません。"
      redirect_to register_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました。"
    redirect_to root_path
  end
end