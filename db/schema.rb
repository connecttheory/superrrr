# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120105202442) do

  create_table "images", :force => true do |t|
    t.integer  "project_id"
    t.string   "caption",                 :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "proj_photo_file_name"
    t.string   "proj_photo_content_type"
    t.integer  "proj_photo_file_size"
    t.datetime "proj_photo_updated_at"
    t.string   "carimage"
    t.integer  "position"
  end

  add_index "images", ["project_id"], :name => "index_images_on_project_id"

  create_table "projects", :force => true do |t|
    t.integer  "user_id"
    t.string   "project_type"
    t.string   "title",                  :limit => 100, :default => "",    :null => false
    t.string   "client"
    t.string   "project_category"
    t.integer  "layout"
    t.boolean  "visible",                               :default => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "project_url"
    t.integer  "custom_image_thumbnail"
  end

  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "first_name",             :limit => 25
    t.string   "last_name",              :limit => 50
    t.string   "username",               :limit => 25
    t.string   "email",                  :limit => 100, :default => "", :null => false
    t.string   "hashed_password",        :limit => 40
    t.string   "salt",                   :limit => 40
    t.text     "about_user"
    t.text     "expertise"
    t.text     "skills"
    t.text     "location"
    t.text     "phone"
    t.boolean  "availability"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "subdomain_name"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "auth_token"
    t.integer  "color_scheme"
    t.integer  "font_face"
    t.integer  "image_size"
    t.string   "header_title"
    t.string   "logo"
    t.string   "footer_title"
    t.string   "avatar"
    t.boolean  "fb_like"
    t.integer  "image_capacity",                        :default => 30
    t.integer  "project_capacity",                      :default => 3
    t.string   "google_analytics"
    t.string   "fb_sm"
    t.string   "twitter_sm"
    t.string   "linkedin_sm"
  end

  add_index "users", ["username"], :name => "index_users_on_username"

  create_table "videos", :force => true do |t|
    t.integer  "project_id"
    t.string   "caption"
    t.string   "video_embed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["project_id"], :name => "index_videos_on_project_id"

end
