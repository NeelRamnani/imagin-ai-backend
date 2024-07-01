class RemoveUrlFromImages < ActiveRecord::Migration[7.1]
  def change
    remove_column :images, :url, :string
  end
end
