class RenameCollectionIdTo < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :CollectionId, :collectionId
  end
end
