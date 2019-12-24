class Song
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.genre = genre unless genre == nil
    self.artist = artist unless artist == nil
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.all
    @@all
  end

  def self.destroy_all
    all.clear
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    new_song = self.new(name)
    new_song.save
    new_song
  end

  def self.find_by_name(name)
    self.all.find {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || self.create(name)
  end

  def self.new_from_filename(file)
    song_data = file.split(" - ")
    self.find_or_create_by_name(song_data[1]).tap do |song|
      song.artist = Artist.find_or_create_by_name(song_data[0])
      song.genre = Genre.find_or_create_by_name(song_data[2].sub(".mp3", ""))
    end
  end

  def self.create_from_filename(file)
    self.new_from_filename(file)
  end
end
