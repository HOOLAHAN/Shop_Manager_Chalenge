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
    sql = 'SELECT id, title, content, views, account_id FROM posts;'
    result_set = DatabaseConnection.exec_params(sql, [])
    posts = []
    result_set.each do |record|
      post = Post.new
      post.id = record['id']
      post.title = record['title']
      post.content = record['content']
      post.views = record['views']
      post.account_id = record['account_id']
      posts << post
    end
    return posts
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, content, views, account_id FROM posts WHERE id = $1;
    # Returns a single Post object.
    sql = 'SELECT id, title, content, views, account_id FROM posts WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]
    post = Post.new
    post.id = record['id']
    post.title = record['title']
    post.content = record['content']
    post.views = record['views']
    post.account_id = record['account_id']
    return post
  end
  
  # creates an post
  # with an post object
  def create(post)
  # Executes the SQL query:
  # INSERT INTO posts (title, content, views) VALUES ($1, $2, $3);
  sql = 'INSERT INTO posts (title, content, views, account_id) VALUES ($1, $2, $3, $4);'
  sql_params = [post.title, post.content, post.views, post.account_id]
  DatabaseConnection.exec_params(sql, sql_params)
  return nil
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
