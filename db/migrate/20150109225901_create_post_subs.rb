class CreatePostSubs < ActiveRecord::Migration
  def change
    create_table :post_subs do |t|
      t.references :post, index: true
      t.references :sub, index: true

      t.timestamps null: false
    end
    add_foreign_key :post_subs, :posts
    add_foreign_key :post_subs, :subs
    add_index :post_subs, [:post_id, :sub_id]
  end
end
