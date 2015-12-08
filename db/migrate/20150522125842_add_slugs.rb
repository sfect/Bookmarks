class AddSlugs < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string
    add_column :posts, :slug, :string
    add_column :categories, :slug, :stiring
  end
end
