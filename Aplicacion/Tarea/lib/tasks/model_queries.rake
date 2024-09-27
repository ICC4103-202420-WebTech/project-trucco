namespace :db do

    task :model_queries => :environment do
    
    puts("Query 0: Sample query; show all the users")
    
    result = User.all
    
    puts(result)
    
    puts("EOQ") # End Of Query -- always add this line after a query.
    puts("Query 1: Name of the student with the most enrolled courses")
    most_enrolled_student = User.joins(:enrollments)
                                 .select("users.*, COUNT(enrollments.id) AS course_count")
                                 .group("users.id")
                                 .order("course_count DESC")
                                 .first
    puts(most_enrolled_student&.name)
    puts("EOQ")

    puts("Query 2: Show the course that has the most lessons")
    course_with_most_lessons = Course.joins(:lessons)
                                      .select("courses.*, COUNT(lessons.id) AS lesson_count")
                                      .group("courses.id")
                                      .order("lesson_count DESC")
                                      .first
    puts(course_with_most_lessons&.title)
    puts("EOQ")

    puts("Query 3: Show the name of the course creator that has created the most courses")
    creator_with_most_courses = User.joins(:instructed_courses)
                                     .select("users.*, COUNT(courses.id) AS course_count")
                                     .group("users.id")
                                     .order("course_count DESC")
                                     .first
    
    if creator_with_most_courses
      puts("#{creator_with_most_courses.name} has created #{creator_with_most_courses.course_count} courses.")
    else
      puts("No course creators found.")
    end
    
    puts("EOQ")

    puts("Query 4: Show the last 3 created courses")
    last_three_courses = Course.order(created_at: :desc).limit(3)
    last_three_courses.each { |course| puts(course.title) }
    puts("EOQ")

    puts("Query 5: Show the full name of the student who has the most progress on a course")
    student_with_most_progress = User.joins(:progresses)
                                      .select("users.*, COUNT(progresses.id) AS progress_count")
                                      .group("users.id")
                                      .order("progress_count DESC")
                                      .first
    puts(student_with_most_progress&.name)
    puts("EOQ")

    puts("Query 6: Show the title of the course that has the most current students")
    course_with_most_current_students = Course.joins(:enrollments)
                                               .select("courses.*, COUNT(enrollments.id) AS student_count")
                                               .group("courses.id")
                                               .order("student_count DESC")
                                               .first
    puts(course_with_most_current_students&.title)
    puts("EOQ")

    puts("Query 7: Show the title and number of lessons of the course that has been completed most times")
    course_completed_most_times = Course.joins(:progresses)
                                          .select("courses.*, COUNT(progresses.id) AS completion_count")
                                          .where(progresses: { completed: true })
                                          .group("courses.id")
                                          .order("completion_count DESC")
                                          .first
    puts("#{course_completed_most_times&.title} - Lessons: #{course_completed_most_times&.lessons.count}")
    puts("EOQ")
    end
    
    end