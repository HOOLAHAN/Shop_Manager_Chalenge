# file: spec/cohort_repository_spec.rb
require 'cohort_repository'

  def reset_cohorts_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2' })
    connection.exec(seed_sql)
  end

describe CohortRepository do
  before(:each) do 
    reset_cohorts_table
  end

  it 'finds cohort 1 with related students' do
    repository = CohortRepository.new
    cohort = repository.find_with_students(1)
    expect(cohort.cohort_name).to eq('October')
    expect(cohort.starting_date).to eq('2022-01-10')
    expect(cohort.students.length).to eq (2)
    expect(cohort.students[0].name).to eq 'Iain'
  end

  it 'finds cohort 2 with related students' do
    repository = CohortRepository.new
    cohort = repository.find_with_students(2)
    expect(cohort.cohort_name).to eq('September')
    expect(cohort.starting_date).to eq('2022-01-09')
    expect(cohort.students.length).to eq (2)
    expect(cohort.students[0].name).to eq 'Sam'
  end

end