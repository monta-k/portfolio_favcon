class RenameTypeColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :type, :track_type
  end
end
