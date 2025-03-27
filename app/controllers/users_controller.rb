class UsersController < ApplicationController
  before_action :move_to_signed_in

  def show
    @user = current_user
    @posts = current_user.posts.all
  end

  def delete_avatar
    @user = current_user
    @user.avatar.purge # ActiveStorageで画像を削除
    redirect_to users_profile_path
  end

  private

  def move_to_signed_in
    unless user_signed_in?
      # サインインしていないユーザーはログインページが表示される
      redirect_to "/users/sign_in"
    end
  end
end
