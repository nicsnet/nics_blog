class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.boolean :published

      t.timestamps
    end
    add_index :articles, [:user_id, :created_at]
  end
end