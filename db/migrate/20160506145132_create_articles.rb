class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.boolean :published
      t.integer :author_id

      t.timestamps null: false
    end
    add_index :articles, :author_id
  end
end
