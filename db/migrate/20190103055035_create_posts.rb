class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.integer :type
      t.string :artistName
      t.integer :artistId
      t.string :trackName
      t.integer :trackId
      t.string :genre
      t.text :content

      t.timestamps
    end
    add_index :posts, [:user_id, :created_at]
  end
end
