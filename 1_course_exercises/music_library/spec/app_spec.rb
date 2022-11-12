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

  it 'when the user inputs 1 it prints a list of albums' do
    io = double :io
    expect(io).to receive(:puts).with("Welcome to the music library manager!").ordered
    expect(io).to receive(:puts).with("").ordered
    expect(io).to receive(:puts).with("What would you like to do?").ordered
    expect(io).to receive(:puts).with(" 1 - List all albums").ordered
    expect(io).to receive(:puts).with(" 2 - List all artists").ordered
    expect(io).to receive(:puts).with("Enter your choice:").ordered
    expect(io).to receive(:gets).and_return("1").ordered
    expect(io).to receive(:puts).with("Here is the list of albums:").ordered
    expect(io).to receive(:puts).with("1 - Doolittle - 1989 - 1")
    expect(io).to receive(:puts).with("2 - Surfer Rosa - 1988 - 1")
    expect(io).to receive(:puts).with("3 - Waterloo - 1974 - 2")
    expect(io).to receive(:puts).with("4 - Super Trouper - 1980 - 2")
    expect(io).to receive(:puts).with("5 - Bossanova - 1990 - 1")

    album_repository = AlbumRepository.new
    artist_repository = ArtistRepository.new
    app = Application.new('music_library_test', io, album_repository, artist_repository)
    app.run 
  end

  it 'when the user inputs 2 it prints a list of artists' do
    io = double :io
    expect(io).to receive(:puts).with("Welcome to the music library manager!").ordered
    expect(io).to receive(:puts).with("").ordered
    expect(io).to receive(:puts).with("What would you like to do?").ordered
    expect(io).to receive(:puts).with(" 1 - List all albums").ordered
    expect(io).to receive(:puts).with(" 2 - List all artists").ordered
    expect(io).to receive(:puts).with("Enter your choice:").ordered
    expect(io).to receive(:gets).and_return("2").ordered
    expect(io).to receive(:puts).with("Here is the list of artists:").ordered
    expect(io).to receive(:puts).with("1 - Pixies - Rock").ordered
    expect(io).to receive(:puts).with("2 - ABBA - Pop").ordered
    expect(io).to receive(:puts).with("3 - Taylor Swift - Pop").ordered
    expect(io).to receive(:puts).with("4 - Nina Simone - Pop").ordered
    expect(io).to receive(:puts).with("5 - 50 Cent - RAP").ordered

    album_repository = AlbumRepository.new
    artist_repository = ArtistRepository.new
    app = Application.new('music_library_test', io, album_repository, artist_repository)
    app.run 
  end

end
