class FavoritesController < ApplicationController
  def create
    @favorite_post = current_user.favorites.create(post_id: params[:post_id])
    redirect_back(fallback_location: posts_path)
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @favorite_post = current_user.favorites.find_by(post_id: @post.id)
    @favorite_post.destroy
    redirect_back(fallback_location: posts_path)
  end
end
