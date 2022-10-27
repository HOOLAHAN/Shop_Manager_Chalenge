# file: app.rb

=begin
require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

artist_repository = ArtistRepository.new
album_repository = AlbumRepository.new

# artist_repository.all.each do |artist|
#   p artist
# end

# album_repository.all.each do |album|
#   p album
# end

# artist = artist_repository.find(1)
# puts artist.name
# album = album_repository.find(1)
# puts album.title

=end



require_relative './lib/album_repository'
require_relative './lib/artist_repository'
require_relative './lib/database_connection'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    # "Runs" the terminal application so it can ask the user to enter some input and then decide to run the appropriate action or behaviour.
    # Use `@io.puts` or `@io.gets` to write output and ask for user input.
    @io.puts 'Welcome to the music library manager!'
    @io.puts ''
    @io.puts 'What would you like to do?'
    @io.puts ' 1 - List all albums'
    @io.puts ' 2 - List all artists'
    @io.puts 'Enter your choice:'
    user_input = @io.gets.chomp
    if user_input == '1'
      @io.puts 'Here is the list of albums:'
      return list_albums
    elsif user_input == '2'
      @io.puts 'Here is the list of artists:'
      return list_artists
    else
      @io.puts "Input must be 1 or 2"
    end
  end
end

private

def list_albums
  sql = 'SELECT id, title, release_year, artist_id FROM albums;'
  result_set = DatabaseConnection.exec_params(sql, [])
  result_set.each do |cell|
    @io.puts cell.values.join(" - ")
  end
end

def list_artists
  sql = 'SELECT id, name, genre FROM artists;'
  result_set = DatabaseConnection.exec_params(sql, [])
  result_set.each do |cell|
    @io.puts cell.values.join(" - ")
  end
end

# Don't worry too much about this if statement. It is basically saying "only run the following code if this is the main file being run, instead of having been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end

