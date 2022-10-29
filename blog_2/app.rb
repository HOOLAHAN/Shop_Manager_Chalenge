# file: app.rb

require_relative 'lib/database_connection'
require_relative 'lib/post_repository'
require_relative 'lib/tag_repository'

class Application

  def initialize (database_name)
    DatabaseConnection.connect(database_name)
    @post = PostRepository.new
    @tag = TagRepository.new
  end

  def search_posts(tag_name)
    result = @post.find_by_tag(tag_name)
    puts "Posts with #{tag_name} tag:"
    result.each do |item|
      puts "* #{item.id}: #{item.title}"
    end
  end

  def search_tags(post_id)
    result = @tag.find_by_post(post_id)
    puts "Tags relating to Post ##{post_id}:"
    result.each do |item|
      puts "* #{item.name}"
    end
  end
  
end

if __FILE__ == $0
  app = Application.new(
    'blog_2',
  )
  app.search_posts('coding')
  app.search_tags('2')
end