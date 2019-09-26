class AddArticleImageToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts,:article_image,:string
  end
end
