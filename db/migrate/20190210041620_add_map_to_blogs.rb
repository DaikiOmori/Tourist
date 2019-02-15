class AddMapToBlogs < ActiveRecord::Migration[5.0]
  def change
    add_column :blogs, :address, :text
  end
end
