# Table name: posts
# Repository class
# (in lib/post_repository.rb)

require 'post'

class PostRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content, views, account_id FROM posts;

    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, content, views, account_id FROM posts WHERE id = $1;

    # Returns a single Post object.
  end
  
  # creates an post
  # with an post object
  def create(post)
  # Executes the SQL query:
  # INSERT INTO posts (title, content, views) VALUES ($1, $2, $3);

  #returns nothing
  end

  # delete an post
  # with an post object
  def delete(id)
  # Executes the SQL query:
  # DELETE FROM posts WHERE id = $1;

  # returns nothing
  end
end
