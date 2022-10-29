# file: app.rb

require_relative 'lib/database_connection'
require_relative 'lib/post_repository'

class Application

  def initialize (database_name)
    DatabaseConnection.connect(database_name)
    @post = PostRepository.new
  end

  def search_posts(tag_name)
    result = @post.find_by_tag(tag_name)
    puts "Posts with #{tag_name} tag:"
    result.each do |item|
      puts "* #{item.id}: #{item.title}"
    end
  end

end

if __FILE__ == $0
  app = Application.new(
    'blog_2',
  )
  app.search_posts('coding')
end