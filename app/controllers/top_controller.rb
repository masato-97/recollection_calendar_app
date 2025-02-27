class TopController < ApplicationController
  before_action :move_to_signed_in
  
  def index
  end

  private

  def move_to_signed_in
    if user_signed_in?
      redirect_to "/memories"
    end
  end
end
