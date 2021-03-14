Admin.create! email: "chung.hitc97@gmail.com",
  password: "123123",
  password_confirmation: "123123"

User.create! name: "chung",
  mail: "chung.hitc97@gmail.com",
  password: "123123",
  password_confirmation: "123123",
  admin: true,
  activated: true,
  activated_at: Time.zone.now

9.times do |n|
  name  = Faker::Name.name
  mail = "test#{n+1}@test.com"
  password = "password"
  User.create! name: name,
    mail: mail,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now
end

category_list = ["Development", "Business", "Design", "Music", "Art", "Fitness"]
category_list.each do |category|
  Category.create! name: category
end

categories = Category.all
categories.each do |category|
  5.times do |n|
    Course.create! name: Faker::Educator.subject,
      description: Faker::Quote.famous_last_words,
      available: true,
      category_id: category.id
  end
end

courses = Course.all
courses.each do |course|
  5.times do |n|
    Lesson.create! name: Faker::Educator.course_name,
      description: Faker::Quote.famous_last_words,
      video: "https://www.youtube.com/embed/DjB1OvEYMhY?enablejsapi=1",
      course_id: course.id,
      sequence: n+1
  end
end

tag_list = ["Beginner", "Intermediate", "Advanced", "Expert"]
tag_list.each do |tag|
  Tag.create! name: tag
end

tags = Tag.all
courses.each do |course|
  rand_tags = tags.sample(rand(1..2))
  rand_tags.each do |rand_tag|
    CourseTag.create! tag_id: rand_tag.id,
      course_id: course.id
  end
end

lessons = Lesson.all
lessons.each do |lesson|
  rand(3..5).times do
    Faker::Config.locale = :en
    Question.create! content: Faker::Lorem.question(word_count: 4),
      lesson_id: lesson.id
  end
end

questions = Question.all
questions.each do |question|
  3.times do
    Faker::Config.locale = :en
    Answer.create! content: Faker::Lorem.sentence(word_count: 3),
      question_id: question.id,
      point: 0
  end
  answers = Answer.where(question_id: question.id)
  answer = answers.sample(1).first
  answer.point = 1
  answer.save
end

users = User.all
users.each do |user|
  rand_courses = courses.sample(rand(1..6))
  rand_courses.each do |rand_course|
    UserCourse.create! course_id: rand_course.id,
      user_id: user.id
  end
end

users.each do |user|
  rand_tags = tags.sample(rand(1..2))
  rand_tags.each do |rand_tag|
    FollowTag.create! tag_id: rand_tag.id,
      user_id: user.id
  end
end

users.each do |user|
  user_courses = user.user_courses
  user_courses.each do |user_course|
    user_lesson = Lesson.where(course_id: user_course.course_id).first
    UserLesson.create! lesson_id: user_lesson.id,
    user_id: user.id
  end
end

courses.each do |course|
  users.each do |user|
    if [true, false].sample && user.courses.find_by(id: course.id).present?
      CourseComment.create! user_id: user.id,
        course_id: course.id,
        content: Faker::Quote.famous_last_words
    end
  end
end

courses.each do |course|
  users.each do |user|
    if [true, false].sample && user.courses.find_by(id: course.id).present?
      CourseRate.create! user_id: user.id,
        course_id: course.id,
        point: rand(1..5)
    end
  end
end
