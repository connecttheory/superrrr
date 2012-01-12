class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references :user
      t.string "project_type"
      t.string "title", :default => "", :null => false, :limit => 100
      t.string "client"
      t.string "project_category"
      t.integer "layout", :default => 1, :null => false
      t.boolean "visible", :default => false
      t.text "description"
      
      t.timestamps
    end
    add_index("projects", "user_id")
  end
end
