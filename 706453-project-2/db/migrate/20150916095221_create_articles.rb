class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :source
      t.string :title
      t.string :date
      t.text :summary
      t.string :author
      t.text :image
      t.text :link

      t.timestamps null: false
    end
  end
end
