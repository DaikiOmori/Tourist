class AddMapInfoToBlogs < ActiveRecord::Migration[5.0]
  def change
    add_column :blogs, :longitude, :float
  end
end
