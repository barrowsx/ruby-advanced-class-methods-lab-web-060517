require 'pry'

class Song
  attr_accessor :name, :artist_name
  @@all = []

  def initialize(song_name)
    @name = song_name
  end

  def self.artist_name=(artist_name)
    @artist_name = artist_name
  end

  def self.create
    canta = Song.new('')
    @@all << canta
    canta
  end

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.new_by_name(song_name)
    canta = Song.new(song_name)
  end

  def self.create_by_name(song_name)
    canta = Song.new(song_name)
    canta.save
    canta
  end

  def self.find_by_name(song_name)
    self.all.each do |song|
      if song.name == song_name
        # binding.pry
        return song
      end
    end
  end

  def self.find_or_create_by_name(song_name)
    if self.find_by_name(song_name) == []
      return self.create_by_name(song_name)
    end
    self.find_by_name(song_name)
    # binding.pry
  end

  def self.alphabetical
    self.all.sort_by do |song|
      song.name
    end
  end

  def self.new_from_filename(mp3_name)
    working_name = mp3_name.split("-").map do |name|
      name.strip
    end
    working_name[1].slice!(".mp3")
    new_song = self.create_by_name(working_name[1])
    new_song.artist_name = working_name[0]
    new_song
    # binding.pry
  end

  def self.create_from_filename(mp3_name)
    new_song = self.new_from_filename(mp3_name)
    new_song.save
  end

  def self.destroy_all
    self.all.map! do |song|
      nil
    end.compact!
  end
end
