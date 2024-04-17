class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :tag_id
      t.string :stone_name ,null: false
      t.text :caption ,null: false
     
      t.timestamps
    end
  end
end
