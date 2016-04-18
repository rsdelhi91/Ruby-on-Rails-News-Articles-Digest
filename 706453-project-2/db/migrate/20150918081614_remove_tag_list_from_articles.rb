class RemoveTagListFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :tag_list, :string
  end
end
