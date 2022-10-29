# file: app.rb

require_relative 'lib/database_connection'

DatabaseConnection.connect('blog')

# Perform a SQL query on the database and get the result set.
sql = 'SELECT id, title FROM posts;'

result = DatabaseConnection.exec_params(sql, [])

result.each do |record|
  p record
end