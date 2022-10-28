# file: app.rb

require_relative 'lib/database_connection'
require_relative 'lib/cohort_repository'

class Application

  def initialize (database_name)
    DatabaseConnection.connect(database_name)
    @cohort = CohortRepository.new
  end

  def search_cohort(id)
    result = @cohort.find_with_students(id)
    puts "Cohort name: #{result.cohort_name}"
    puts "Cohort start date: #{result.starting_date}"
    puts "Cohort size: #{result.students.length}"
    puts "Students in #{result.cohort_name}:"
    result.students.each do |item|
      puts item.name
    end
  end

end

if __FILE__ == $0
  app = Application.new(
    'student_directory_2',
  )
  app.search_cohort('1')
end