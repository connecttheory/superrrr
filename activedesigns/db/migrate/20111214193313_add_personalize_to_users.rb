class AddPersonalizeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :color_scheme, :integer
    add_column :users, :font_face, :integer
    add_column :users, :image_size, :integer
    add_column :users, :header_title, :string
    add_column :users, :logo, :string
    add_column :users, :footer_title, :string
  end
end
