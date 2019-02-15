class BlogsController < ApplicationController
before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]  
before_action :correct_user, only: [:destroy, :edit, :update]
  def show
    @blog = Blog.find(params[:id])
    @user = @blog.user
    @address = @blog.address
    @hash = Gmaps4rails.build_markers(@address) do |address, marker|
      marker.lat @blog.latitude
      marker.lng @blog.longitude
      marker.json({title: @blog.title})
    end
  end

  def new
    @blog = Blog.new
  end
  
  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to @blog
    else
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render :edit
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      flash[:success] = 'blogは正常に更新されました'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = 'blogは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    flash[:success] = 'blogは正常に削除されました'
    redirect_back(fallback_location: root_path)
  end
  
private

  def blog_params
    params.require(:blog).permit(:blog_image, :title, :address, :content, :profile_image, :latitude, :longitude)
  end
  
  def correct_user
    @blog = current_user.blogs.find_by(id: params[:id])
    unless @blog
      flash[:danger] = '他のユーザーのブログに関する変更はできません'
      redirect_to root_url
    end
  end

end
