class MemoriesController < ApplicationController
  before_action :move_to_signed_in
  before_action :set_beginning_of_week

  def index
    start_date = params.fetch(:start_date, Date.today).to_date
    @memories = Memory.where(user_id: current_user.id, day: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
    @memories_month = Memory.memories_this_month(current_user.id, start_date).order(day: :desc)
  end

  def new
    @memory = Memory.new
  end

  def create
    @memory = current_user.memories.build(memory_params)
    if @memory.save
      redirect_to memory_path(@memory)
    else
      render :new
    end
  end

  def show
    @memory = current_user.memories.find(params[:id])
  end

  def oneday
    @memories  = Memory.where(day: params[:id])

    if @memories.empty?
      redirect_to new_memory_path
    end
  end

  def all
    @memories = Memory.where(user_id: current_user.id).order(day: :desc)
  end

  def edit
    @memory = current_user.memories.find(params[:id])
  end

  def update
    @memory = current_user.memories.find(params[:id])
    if @memory.update(memory_params)
      redirect_to memory_path(@memory)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @memory = current_user.memories.find(params[:id])
    @memory.destroy!
    redirect_to all_memories_path
  end

  def compare
    start_date = params.fetch(:start_date, Date.today).to_date
    @this_month_memories = Memory.memories_this_month(current_user.id, start_date)
    @last_month_memories = Memory.memories_last_month(current_user.id, start_date)
    @two_month_ago_memories = Memory.memories_2month_ago(current_user.id, start_date)
    @three_month_ago_memories = Memory.memories_3month_ago(current_user.id, start_date)
    @four_month_ago_memories = Memory.memories_4month_ago(current_user.id, start_date)
    @five_month_ago_memories = Memory.memories_5month_ago(current_user.id, start_date)
    @six_month_ago_memories = Memory.memories_6month_ago(current_user.id, start_date)
  end

  private

  def move_to_signed_in
    unless user_signed_in?
      # サインインしていないユーザーはトップページが表示される
      redirect_to root_path
    end
  end

  def memory_params
    params.require(:memory).permit(:day, :title, :body, :main_image, :sub_image, :score)
  end

  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end
end
