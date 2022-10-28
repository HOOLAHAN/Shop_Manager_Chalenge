# file: spec/cohort_repository_spec.rb
require 'cohort_repository'

  def reset_cohorts_table
    seed_sql = File.read('spec/seeds_cohorts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2' })
    connection.exec(seed_sql)
  end

  def reset_students_table
    seed_sql = File.read('spec/seeds_students.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2' })
    connection.exec(seed_sql)
  end


describe CohortRepository do
  before(:each) do 
    reset_cohorts_table
  end
  # (your tests will go here).

  it 'finds cohort 1 with related students' do
    repository = CohortRepository.new
    cohort = repository.find_with_students('2')
    expect(cohort.cohort_name).to eq('October')
    expect(cohort.starting_date).to eq('2022-01-10')
    expect(cohort.students.length).to eq (2)
    # expect(cohort.students[0].name).to eq 'Iain'
  end
end