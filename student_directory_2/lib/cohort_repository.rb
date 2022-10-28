# File: lib/cohort_repository.rb

require_relative 'cohort'
require_relative 'student'

class CohortRepository
  def find_with_students(id)
      
    sql = 'SELECT  cohorts.id AS "id", 
            cohorts.cohort_name AS "cohort_name", 
            cohorts.starting_date AS "starting_date",
            students.name AS "name"
    FROM cohorts
    JOIN students
    ON students.cohort_id = cohorts.id
    WHERE cohorts.id = $1;'
    
    sql_params = [id]

    result = DatabaseConnection.exec_params(sql, sql_params)

    cohort = Cohort.new

    cohort.id = result.first['id']
    cohort.cohort_name = result.first['cohort_name']
    cohort.starting_date = result.first['starting_date']
    cohort.students = []
    
    result.each do |record|
      student = Student.new
      student.id = record['student_id']
      student.name = record['name']

      cohort.students << student
    end
    return cohort
  end
end