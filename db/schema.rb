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

ActiveRecord::Schema.define(version: 2020_10_12_034241) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.integer "question_id", null: false
    t.string "content"
    t.integer "point"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "course_comments", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "user_id", null: false
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_course_comments_on_course_id"
    t.index ["user_id"], name: "index_course_comments_on_user_id"
  end

  create_table "course_rates", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "user_id", null: false
    t.integer "point"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_course_rates_on_course_id"
    t.index ["user_id"], name: "index_course_rates_on_user_id"
  end

  create_table "course_tags", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_course_tags_on_course_id"
    t.index ["tag_id"], name: "index_course_tags_on_tag_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "available", default: true
    t.index ["category_id"], name: "index_courses_on_category_id"
  end

  create_table "follow_tags", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tag_id"], name: "index_follow_tags_on_tag_id"
    t.index ["user_id"], name: "index_follow_tags_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "video"
    t.integer "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence"
    t.index ["course_id"], name: "index_lessons_on_course_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "lesson_id", null: false
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_id"], name: "index_questions_on_lesson_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_answers", force: :cascade do |t|
    t.integer "answer_id", null: false
    t.integer "user_exam_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["answer_id"], name: "index_user_answers_on_answer_id"
    t.index ["user_exam_id"], name: "index_user_answers_on_user_exam_id"
  end

  create_table "user_courses", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "user_id", null: false
    t.string "status", default: "nil"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["course_id"], name: "index_user_courses_on_course_id"
    t.index ["deleted_at"], name: "index_user_courses_on_deleted_at"
    t.index ["user_id"], name: "index_user_courses_on_user_id"
  end

  create_table "user_exams", force: :cascade do |t|
    t.integer "lesson_id", null: false
    t.integer "user_id", null: false
    t.float "point", default: 0.0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_id"], name: "index_user_exams_on_lesson_id"
    t.index ["user_id"], name: "index_user_exams_on_user_id"
  end

  create_table "user_lessons", force: :cascade do |t|
    t.integer "lesson_id", null: false
    t.integer "user_id", null: false
    t.string "status", default: "nil"
    t.integer "video_status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_user_lessons_on_deleted_at"
    t.index ["lesson_id"], name: "index_user_lessons_on_lesson_id"
    t.index ["user_id"], name: "index_user_lessons_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "mail"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "google_token"
    t.string "google_refresh_token"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["mail"], name: "index_users_on_mail", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "course_comments", "courses"
  add_foreign_key "course_comments", "users"
  add_foreign_key "course_rates", "courses"
  add_foreign_key "course_rates", "users"
  add_foreign_key "course_tags", "courses"
  add_foreign_key "course_tags", "tags"
  add_foreign_key "courses", "categories"
  add_foreign_key "follow_tags", "tags"
  add_foreign_key "follow_tags", "users"
  add_foreign_key "lessons", "courses"
  add_foreign_key "questions", "lessons"
  add_foreign_key "user_answers", "answers"
  add_foreign_key "user_answers", "user_exams"
  add_foreign_key "user_courses", "courses"
  add_foreign_key "user_courses", "users"
  add_foreign_key "user_exams", "lessons"
  add_foreign_key "user_exams", "users"
  add_foreign_key "user_lessons", "lessons"
  add_foreign_key "user_lessons", "users"
end
