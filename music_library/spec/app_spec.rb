# File: spec/app_spec.rb

require_relative '../app'

describe Application do

  def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
  end

  before(:each) do
    reset_tables
  end


  context 'run method' do
    it 'prints a welcome message, menu and asks the user for input' do
      io = double :io
      expect(io).to receive(:puts).with("Welcome to the music library manager!").ordered
      expect(io).to receive(:puts).with("").ordered
      expect(io).to receive(:puts).with("What would you like to do?").ordered
      expect(io).to receive(:puts).with(" 1 - List all albums").ordered
      expect(io).to receive(:puts).with(" 2 - List all artists").ordered
      expect(io).to receive(:puts).with("Enter your choice: ").ordered
      expect(io).to receive(:gets).and_return("1").ordered

      album_repository = AlbumRepository.new
      artist_repository = ArtistRepository.new
      app = Application.new(database_name, io, album_repository, artist_repository)
      app.run 
    end
  end
end
