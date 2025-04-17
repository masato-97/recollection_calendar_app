class PostsController < ApplicationController
  before_action :move_to_signed_in
  before_action :set_memory, only: %i[new create show edit update destroy]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)
    @tag_list = @posts.map(&:post_tags).flatten.uniq
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

    if @post.save_with_post_tags(tag_names: params.dig(:post, :tag_names).split(",").uniq)
      redirect_to memory_post_path(memory_id: @post.memory_id, id: @post.id), success: "ポストを作成しました"
    else
      flash.now[:danger] = "ポストを作成できませんでした"
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    @post.assign_attributes(post_params)

    if @post.save_with_post_tags(tag_names: params.dig(:post, :tag_names).split(",").uniq)
      redirect_to memory_post_path(@memory, @memory.post), success: "ポストを更新しました"
    else
      flash.now[:danger] = "ポストを更新できませんでした"
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to posts_path, success: "ポストを削除しました"
  end

  def search_tag
    @tag_list = PostTag.all
    @tag = PostTag.find(params[:post_tag_id])
    @tag_posts = @tag.posts
  end

  def search_mypost_tag
    @posts = current_user.posts.all
    @tag_list = @posts.map(&:post_tags).flatten.uniq
    @tag = PostTag.find(params[:post_tag_id])
    @tag_posts = @tag.posts
  end

  private

  def move_to_signed_in
    unless user_signed_in?
      # サインインしていないユーザーはトップページが表示される
      redirect_to root_path
    end
  end

  def set_memory
    @memory = Memory.find(params[:memory_id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
