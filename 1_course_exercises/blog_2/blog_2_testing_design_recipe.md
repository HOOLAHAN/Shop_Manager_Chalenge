# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE
Table: posts
Columns:
id | title
Table: tags
Columns:
id | name
Table: posts_tags
Columns:
post_id | tag_id
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)
-- Write your SQL seed here. 
-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)
TRUNCATE TABLE posts, tags, posts_tags RESTART IDENTITY CASCADE; 
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title) VALUES ('How to use Git');
INSERT INTO posts (title) VALUES ('Ruby classes');
INSERT INTO posts (title) VALUES ('Using IRB');
INSERT INTO posts (title) VALUES ('My weekend in Edinburgh');
INSERT INTO posts (title) VALUES ('The best chocolate cake EVER');
INSERT INTO posts (title) VALUES ('A foodie week in Spain');
INSERT INTO posts (title) VALUES ('SQL basics');


INSERT INTO tags (name) VALUES ('coding');
INSERT INTO tags (name) VALUES ('travel');
INSERT INTO tags (name) VALUES ('cooking');
INSERT INTO tags (name) VALUES ('ruby');
INSERT INTO tags (name) VALUES ('sql');

INSERT INTO posts_tags (post_id, tag_id) VALUES (1, 1);
INSERT INTO posts_tags (post_id, tag_id) VALUES (2, 1);
INSERT INTO posts_tags (post_id, tag_id) VALUES (2, 4);
INSERT INTO posts_tags (post_id, tag_id) VALUES (3, 1);
INSERT INTO posts_tags (post_id, tag_id) VALUES (3, 4);
INSERT INTO posts_tags (post_id, tag_id) VALUES (4, 2);
INSERT INTO posts_tags (post_id, tag_id) VALUES (5, 3);
INSERT INTO posts_tags (post_id, tag_id) VALUES (6, 2);
INSERT INTO posts_tags (post_id, tag_id) VALUES (6, 3);
INSERT INTO posts_tags (post_id, tag_id) VALUES (7, 1);
INSERT INTO posts_tags (post_id, tag_id) VALUES (7, 5);

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: posts
# Model class
# (in lib/post.rb)
class Post
end
# Repository class
# (in lib/post_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students
# Model class
# (in lib/post.rb)
class Post
  # Replace the attributes by your own columns.
  attr_accessor :id, :title
end
# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: posts
# Repository class
# (in lib/post_repository.rb)
class PostRepository
  def find_by_tag(name)
  
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES
# 1
# Get all posts
repo = PostRepository.new
posts = repo.find_by_tag('coding')
posts.length # =>  2
posts[0].id # =>  1
posts[0].name # =>  'How to use Git'
posts[1].id # =>  2
posts[1].name # =>  'Ruby Classes'
posts[2].id # =>  3
posts[2].name # =>  'Using IRB'
posts[3].id # =>  7
posts[3].name # =>  'SQL basics'

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE
# file: spec/student_repository_spec.rb
def reset_posts_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_2' })
  connection.exec(seed_sql)
end
describe PostRepository do
  before(:each) do 
    reset_posts_table
  end
  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._