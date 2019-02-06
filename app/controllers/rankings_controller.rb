class RankingsController < ApplicationController
  def like
    @ranking_counts = Like.ranking
    @blogs = Blog.find(@ranking_counts.keys)
  end
end
