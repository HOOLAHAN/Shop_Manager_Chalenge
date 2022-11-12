# (in lib/post_repository.rb)

require_relative './post'

class PostRepository
  def find_by_tag(name)
    sql = 'SELECT posts.id AS post_id, 
          posts.title AS post_title
          FROM posts
          JOIN posts_tags ON posts_tags.post_id = posts.id
          JOIN tags ON posts_tags.tag_id = tags.id	
          WHERE name = $1;'

    sql_params = [name]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    posts = []

    result_set.each do |record|
      post = Post.new
      post.id = record["post_id"]
      post.title = record["post_title"]
      posts << post 
    end
    return posts
  end
end