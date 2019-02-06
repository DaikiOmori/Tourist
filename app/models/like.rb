class Like < ApplicationRecord
  belongs_to :user
  belongs_to :blog
  def self.ranking
    self.group(:blog_id).order('count_blog_id DESC').limit(10).count(:blog_id)
  end

end
