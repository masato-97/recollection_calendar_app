class UsersController < ApplicationController
  before_action :move_to_signed_in
  
  def show
    @user = current_user
  end

  private

  def move_to_signed_in
    unless user_signed_in?
      # サインインしていないユーザーはログインページが表示される
      redirect_to "/users/sign_in"
    end
  end
end
