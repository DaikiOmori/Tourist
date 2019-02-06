class UsersController < ApplicationController
before_action :require_user_logged_in, only: [:profile_edit, :edit, :update, :destroy_user, :destroy, :likes]
before_action :correct_user, only: [:destroy, :profile_edit, :edit, :update, :destroy_user]

  def show
    @user = User.find(params[:id])
    @blogs = @user.blogs.order('created_at DESC').page(params[:page])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def profile_edit 
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = '正常に更新されました'
      redirect_to @user
    else
      flash.now[:danger] = '更新されませんでした'
      render :edit
    end
  end

  def destroy_user
    @user = User.find(params[:id])
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = 'ユーザーは正常に削除されました'
    redirect_to root_url
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.like_blogs.page(params[:page])
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
  end
  
private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile_image, :profile_description)
  end
  
  def correct_user
    @user = User.find_by(id: params[:id])
    unless @user
      flash[:danger] = '他のユーザーに関する変更はできません'
      redirect_to root_url
    end
  end
end
