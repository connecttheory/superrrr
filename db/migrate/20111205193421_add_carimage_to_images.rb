class AddCarimageToImages < ActiveRecord::Migration
  def change
    add_column :images, :carimage, :string
  end
end
