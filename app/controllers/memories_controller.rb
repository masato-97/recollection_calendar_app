class MemoriesController < ApplicationController
  before_action :move_to_signed_in

  def index
    @memories = Memory.all
  end

  def new
    @memory = Memory.new
  end

  def create
    @memory = current_user.memories.build(memory_params)
    if @memory.save
      redirect_to memories_path
    else
      render :new
    end
  end

  def show
    @memory = Memory.find(params[:id])
  end

  def oneday
    @memories  = Memory.where(day: params[:id])

    if @memories.empty?
      redirect_to new_memory_path
    end
  end

  private

  def move_to_signed_in
    unless user_signed_in?
      # サインインしていないユーザーはログインページが表示される
      redirect_to "/users/sign_in"
    end
  end

  def memory_params
    params.require(:memory).permit(:day, :title, :body, :main_image, :sub_image, :main_image_cache, :sub_image_cache, :star)
  end
end
