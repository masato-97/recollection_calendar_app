class UsersController < ApplicationController
  before_action :move_to_signed_in

  def show
    @user = current_user
    @posts = current_user.posts.all
    @tag_list = @posts.map(&:post_tags).flatten.uniq
  end

  def delete_avatar
    @user = current_user
    @user.avatar.purge # ActiveStorageで画像を削除
    redirect_to users_profile_path
  end

  def set
    @user = current_user
    @reminder = @user.reminder
  end

  private

  def move_to_signed_in
    unless user_signed_in?
      # サインインしていないユーザーはトップページが表示される
      redirect_to root_path
    end
  end
end
