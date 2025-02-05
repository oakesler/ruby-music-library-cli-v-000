class Song 
  attr_accessor :name, :artist, :genre
  #attr_writer :genre, :artist
  #attr_accessor :name, :genre
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist 
    self.genre = genre
  end
  
  def name
    @name
  end
  
  def artist 
    @artist
  end
  
  def artist=(artist)
    #binding.pry
    @artist = artist
    if artist != nil
      artist.add_song(self)
    end
  end
  
  def name=(name)
    @name = name
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def save
    @@all << self
  end
  
  def self.create(name)
    @name = name
    new_song = self.new(name)
    new_song.save
    new_song
  end
  
  def genre 
    @genre
  end
  
  def self.find_or_create_by_name(name)
    if !self.find_by_name(name)
      self.create(name)
      else 
        self.find_by_name(name)
    if !self.find_by_name(name)
      self.create(name)
      self.find_by_name(name)
    else
      self.find_by_name(name)
    end
  end
end
    
  def self.find_by_name(name)
    thing = []
    @@all.each do |item|
      if item.name == name
        thing << item
      end
    end
    thing[0]
  end
  
  def genre=(genre)
    @genre = genre
    if genre != nil
      if !genre.songs.include?(self)
        genre.songs << self
      end
    end
  end
  
  def self.new_from_filename(name)
    name_final = name.scan(/(?<=-\s).*?(?=\s-)/)[0]
    genre_redo_1 = name.scan(/(?<= - ).*?(?=.mp3)/)[0]
    genre_redo_2 = genre_redo_1.gsub(" - ", ",")
    genre_redo_3 = genre_redo_2.split(",")
    genre_redo_final = genre_redo_3[1]
    artist_temp = name.scan(/(?<=\A).*?(?= -)/)[0]
    artist_final = Artist.find_or_create_by_name(artist_temp)
    genre_final = Genre.find_or_create_by_name(genre_redo_final)
    self.new(name_final, artist_final, genre_final)
  end
  
  def self.create_from_filename(name)
    #binding.pry
    halfway = self.new_from_filename(name)
    halfway.save
  end
end
  
