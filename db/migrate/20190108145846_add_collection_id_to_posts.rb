class AddCollectionIdToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :CollectionId, :integer
  end
end
