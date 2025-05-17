class FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @favorite_post = current_user.favorites.new(post_id: @post.id)
    respond_to do |format|
      if @favorite_post.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("favorite_post_#{@post.id}", partial: "favorites/favorite_btn", locals: { post: @post })
        end
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite_post = current_user.favorites.find_by(post_id: @post.id)
    respond_to do |format|
      if @favorite_post.destroy
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("favorite_post_#{@post.id}", partial: "favorites/favorite_btn", locals: { post: @post })
        end
      end
    end
  end
end
