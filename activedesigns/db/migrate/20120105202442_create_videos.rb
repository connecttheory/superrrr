class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.references :project
      t.string :caption
      t.string :video_embed

      t.timestamps
    end
    add_index("videos", "project_id")
  end
end
