class UserController < ApplicationController
  
  # ログイン認証
  before_action :authenticate_user!

  def index
  end

  # プロフィール編集ページ
  def edit_profile
    @user = current_user
  end

  # プロフィール更新
  def update_profile
    @user = current_user
    if @user.update(user_profile_params)
      redirect_to root_path, notice: 'プロフィールが更新されました。'
    else
      render :edit_profile
    end
  end

  private

  def user_profile_params
    params.require(:user).permit( :username, :profile, :avatar)
  end
end


