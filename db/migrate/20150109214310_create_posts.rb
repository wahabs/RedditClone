class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.text :content
      t.references :sub, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :posts, :subs
    add_foreign_key :posts, :users
  end
end
