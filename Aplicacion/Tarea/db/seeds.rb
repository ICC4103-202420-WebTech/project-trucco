# db/seeds.rb

# Clear existing data to avoid duplicates
Enrollment.delete_all
Progress.delete_all
Lesson.delete_all
Course.delete_all
User.delete_all

# Create Users (2 course creators and 5 students)
users = []
2.times do |i|
  users << User.create!(
    name: "Creator #{i + 1}",
    email: "creator#{i + 1}@example.com",
    role: "instructor"
  )
end

5.times do |i|
  users << User.create!(
    name: "Student #{i + 1}",
    email: "student#{i + 1}@example.com",
    role: "student"
  )
end

# Create 4 courses, each with at least 4 lessons
4.times do |i|
  course = Course.create!(
    title: "Course #{i + 1}",
    description: "This is the description for course #{i + 1}.",
    instructor: users.sample { |user| user.role == 'instructor' }
  )

  4.times do |j|
    if j.even?
      # Create a lesson with video content
      Lesson.create!(
        title: "Lesson #{j + 1} of Course #{i + 1}",
        content_type: "video",
        content: "https://www.youtube.com/watch?v=t75B87Lzh4E&list=LL&index=7", # video URL
        course: course
      )
    else
      # Create a lesson with written content using ActionText
      lesson = Lesson.create!(
        title: "Lesson #{j + 1} of Course #{i + 1}",
        content_type: "written",  # Use 'written' instead of 'text'
        course: course
      )
      
      # Set the rich text content after the lesson is created
      lesson.content_rich_text.body = "This is written content for lesson #{j + 1}."
      lesson.save!
    end
  end
end

# Enroll students in courses and add progress
students = users.select { |user| user.role == 'student' }

Course.all.each do |course|
  students.sample(3).each do |student|
    Enrollment.create!(user: student, course: course)

    # Add some progress in the lessons
    course.lessons.each do |lesson|
      progress_percentage = rand(0..100)
      Progress.create!(
        user: student,
        course: course,
        lesson: lesson,
        progress_percentage: progress_percentage,
        completed: progress_percentage == 100
      )
    end
  end
end

puts "Seeding completed!"
