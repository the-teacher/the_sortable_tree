# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140617215136) do

  create_table "admin_pages", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.text     "secret_field"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
    t.integer  "position"
  end

  add_index "admin_pages", ["ancestry"], name: "index_admin_pages_on_ancestry"

  create_table "article_categories", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.text     "secret_field"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
    t.integer  "position"
  end

  add_index "article_categories", ["ancestry"], name: "index_article_categories_on_ancestry"

  create_table "inventory_categories", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.text     "secret_field"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
    t.integer  "position"
  end

  add_index "inventory_categories", ["ancestry"], name: "index_inventory_categories_on_ancestry"

  create_table "pages", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.text     "secret_field"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
    t.integer  "position"
  end

  add_index "pages", ["ancestry"], name: "index_pages_on_ancestry"

end
