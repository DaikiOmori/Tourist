class LikesController < ApplicationController
before_action :require_user_logged_in

  def create
    blog = Blog.find(params[:blog_id])
    current_user.like(blog)
    flash[:success] = '投稿にいいねしました'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    blog = Blog.find(params[:blog_id])
    current_user.unlike(blog)
    flash[:success] = 'いいねを解除しました'
    redirect_back(fallback_location: root_path)
  end
end

