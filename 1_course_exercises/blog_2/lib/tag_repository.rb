# (in lib/post_repository.rb)

require_relative './tag'

class TagRepository
  def find_by_post(post_id)
    sql = 'SELECT tags.id AS tag_id, tags.name AS tag_name
    FROM tags 
      JOIN posts_tags ON posts_tags.tag_id = tags.id
      JOIN posts ON posts_tags.post_id = posts.id
      WHERE posts.id = $1;'

    sql_params = [post_id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    tags = []

    result_set.each do |record|
      tag = Tag.new
      tag.id = record["tag_id"]
      tag.name = record["tag_name"]
      tags << tag
    end
    return tags
  end
end