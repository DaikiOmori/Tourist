class ToppagesController < ApplicationController
  def index
      @blogs = Blog.all.order('created_at DESC').page(params[:page])
  end
end
