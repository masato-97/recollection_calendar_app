class TopController < ApplicationController
  before_action :move_to_signed_in, only: %i[index]

  def index
  end

  def how_to_use
  end

  private

  def move_to_signed_in
    if user_signed_in?
      redirect_to "/memories"
    end
  end
end
