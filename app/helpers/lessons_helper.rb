module LessonsHelper
  def course_registered? course
    current_user.courses.find_by(id: course.id).present?
  end

  def lesson_registered? lesson
    current_user.lessons.find_by(id: lesson.id).present?
  end
  
  def lesson_joined? user, lesson
    user.lessons.find_by(id: lesson.id).present?
  end

  def lessons_asc
    @lessons ||= @course.lessons.by_sequence
  end

  def first_lesson? lesson
    lessons_asc.first == lesson
  end

  def last_lesson? lesson
    lessons_asc.last == lesson
  end

  def joined_previous_lesson? lesson
    lesson_index = lessons_asc.find_index{|e| e==lesson}
    previous_lesson = lessons_asc[lesson_index -1]
    lesson_registered? previous_lesson
  end

  def next_lesson lesson
    return lesson if last_lesson? lesson
    lesson_index = lessons_asc.find_index{|e| e==lesson}
    return lessons_asc[lesson_index +1]
  end

  def exam_list user, lesson
    user.user_exams.where(lesson_id: lesson.id)
  end

  def average_point user, lesson
    exam_list = user.user_exams.where(lesson_id: lesson.id)
    exam_list.blank? ? 0 : exam_list.pluck(:point).inject(:+).to_f / exam_list.size
  end
end
