class PostsController < ApplicationController
  before_action :move_to_signed_in
  before_action :set_memory, only: %i[new create show]

  def index
    @posts = Post.all
  end

  def new
    if @memory.post.present?
      redirect_to memory_post_path(@memory, @memory.post)
    else
      @post = Post.new
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.memory = @memory

    if @post.save
      redirect_to memory_post_path(memory_id: @post.memory_id, id: @post.id)
    else
      render :new
    end
  end

  def show
    @post = current_user.posts.find(params[:id])
  end

  private

  def move_to_signed_in
    unless user_signed_in?
      # サインインしていないユーザーはログインページが表示される
      redirect_to "/users/sign_in"
    end
  end

  def set_memory
    @memory = Memory.find(params[:memory_id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
