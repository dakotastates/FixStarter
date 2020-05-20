# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_19_013946) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.integer "user_id", null: false
    t.integer "problem_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["problem_id"], name: "index_comments_on_problem_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "materials", force: :cascade do |t|
    t.string "name"
    t.integer "quantity"
    t.integer "proposal_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["proposal_id"], name: "index_materials_on_proposal_id"
  end

  create_table "problem_categories", force: :cascade do |t|
    t.integer "problem_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_problem_categories_on_category_id"
    t.index ["problem_id"], name: "index_problem_categories_on_problem_id"
  end

  create_table "problems", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "status", default: false
    t.string "priority"
    t.boolean "declare_winner", default: false
    t.index ["user_id"], name: "index_problems_on_user_id"
  end

  create_table "proposal_comments", force: :cascade do |t|
    t.string "content"
    t.integer "user_id", null: false
    t.integer "proposal_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["proposal_id"], name: "index_proposal_comments_on_proposal_id"
    t.index ["user_id"], name: "index_proposal_comments_on_user_id"
  end

  create_table "proposals", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "user_id", null: false
    t.integer "problem_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "winner", default: false
    t.index ["problem_id"], name: "index_proposals_on_problem_id"
    t.index ["user_id"], name: "index_proposals_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.string "provider"
    t.string "uid"
    t.string "first_name"
    t.string "last_name"
    t.text "about_me"
    t.integer "age"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider"], name: "index_users_on_provider"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_users_on_uid"
  end

  create_table "votes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "proposal_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["proposal_id"], name: "index_votes_on_proposal_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "comments", "problems"
  add_foreign_key "comments", "users"
  add_foreign_key "materials", "proposals"
  add_foreign_key "problem_categories", "categories"
  add_foreign_key "problem_categories", "problems"
  add_foreign_key "problems", "users"
  add_foreign_key "proposal_comments", "proposals"
  add_foreign_key "proposal_comments", "users"
  add_foreign_key "proposals", "problems"
  add_foreign_key "proposals", "users"
  add_foreign_key "votes", "proposals"
  add_foreign_key "votes", "users"
end
