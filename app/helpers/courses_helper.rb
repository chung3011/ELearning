module CoursesHelper
  def rated?
    current_user.course_rates.find_by(course: @course).blank?
  end

  def course_status(user, course)
    user_lesson_ids = user.user_lessons.pluck(:lesson_id).uniq
    course_lesson_ids = course.lesson_ids
    (user_lesson_ids & course_lesson_ids).size.to_f/course_lesson_ids.size*100
  end
end
