# {{music_library}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: artists
Columns:
id | name | genre

Table: albums
Columns
id | title | release_year | artist_id
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds_artists.sql)

-- Write your SQL seed here. 
-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)
TRUNCATE TABLE artists RESTART IDENTITY; -- replace with your own table name.
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO artists (name, genre) VALUES('Pixies', 'Rock');
INSERT INTO artists (name, genre) VALUES('ABBA', 'Pop');

-- (file: spec/seeds_albums.sql)

-- Write your SQL seed here. 
-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)
TRUNCATE TABLE albums RESTART IDENTITY; -- replace with your own table name.
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO albums (title, release_year, artist_id) VALUES('Doolittle', '1989', '1');
INSERT INTO albums (title, release_year, artist_id) VALUES('Surfer Rosa', '1988', '1');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: artists
# Model class
# (in lib/artist.rb)
class Artist
end
# Repository class
# (in lib/artist_repository.rb)
class ArtistRepository
end

class Album
end

class AlbumRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students
# Model class
# (in lib/artist.rb)
class Artist
  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :genre
end
# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'

class Album
  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :release_year, :artist_id
end

```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: artists
# Repository class
# (in lib/artist_repository.rb)
class ArtistRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, genre FROM artists;
    # Returns an array of Artist objects.
  end

# select a single record
# given the id in argument (a number)

def find (id)
  # executes the SQL query
  # SELECT id, name, genre FROM artists WHERE id = $1
  # Returns a single Artist object
end

end

class AlbumRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums;
    # Returns an array of Album objects.
  end

  def find(id)
    # returns a single record using its id. It will perform a filtered SELECT query to retrieve that single row.
  end
  
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES
# 1
# Get all Artists
repo = ArtistRepository.new
artists = repo.all 
artists.length # => 2
artists.first.id # => '1'
artists.first.name # => 'Pixies'

# 2
# Get a single artist
repo = ArtistRepository.new
artist = repo.find(1)
artist.name # => 'Pixies'
artist.genre # => 'Rock'

# 3
# Get a single artist
repo = ArtistRepository.new
artist = repo.find(2)
artist.name # => 'ABBA'
artist.genre # => 'Pop'

# 4
# Get all Albums
repo = AlbumRepository.new
albums = repo.all 
expect(albums.length).to eq (2)
expect(albums.first.id).to eq ('1')
expect(albums.first.title).to eq ('Doolittle')
expect(albums.first.release_year).to eq ('1989')
expect(albums.first.artist_id).to eq ('1')

# 5
# finds a single record using its id
repo = AlbumRepository.new
album = repo.find(1)  # Performs a SELECT query and returns a single Album object.
album.title # => 'Doolittle'
album.release_year # => '1989'
album.artist_id # => '1'

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby


  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_albums_table
  end

```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
