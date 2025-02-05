require "pry"

class MusicLibraryController
  attr_accessor :path, :music
  
  
  
  def initialize(path = "./db/mp3s", import = true)
    @path = path
    @import = import
    @music = MusicImporter.new(path)
    music.import
  end
  
  def call
    user_input_1 = " "
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      while user_input_1 != "exit"
        puts "What would you like to do?"
        user_input_1 = gets.strip
        if user_input_1 == "list songs"
          list_songs
          elsif user_input_1 == "list artists"
          list_artists
          elsif user_input_1 == "list genres"
          list_genres
          elsif user_input_1 == "list artist"
          list_songs_by_artist
          elsif user_input_1 == "list genre"
          list_songs_by_genre
          elsif user_input_1 == "play song"
          play_song
        end
      end
    end
  #end
    #end
    
  def list_songs
    song_array = []
    alpha_file_list = []
    final_file_list = []
    music.files.each do |song|
      song_array << song.scan(/(?<=-\s).*?(?=\s-)/)[0]
    end
    song_array.sort.each do |song|
      music.files.each do |file|
        if file.include? "#{song}"
          alpha_file_list << file
        end
      end
    end 
    x = 1
    alpha_file_list.each do |file|
      final_file_list << "#{x}. #{file.gsub(".mp3", "")}"
    x += 1
    end
    z = 0
    while z <= final_file_list.length - 1
      puts final_file_list[z]
      z += 1
    end
  end
  
  def list_artists
    artist_array = []
    Artist.all.each do |item|
      artist_array << item.name
    end
    x = 1 
    artist_array.sort.each do |item|
      puts "#{x}. #{item}"
      x += 1 
    end
  end
  
   def list_genres
    genre_array = []
    Genre.all.each do |item|
      genre_array << item.name
    end
    x = 1 
    genre_array.sort.each do |item|
      puts "#{x}. #{item}"
      x += 1 
    end
  end
  
  def list_songs_by_artist
    x = 1
    song_array = []
    genre_array = []
    ultimate_array = []
    puts "Please enter the name of an artist:"
    user_input = gets.strip
    artist_object = Artist.find_or_create_by_name(user_input)
    artist_object.songs.each do |object|
      ultimate_array << "#{object.name} - #{object.genre.name}"
    end
    ultimate_array.sort.each do |item|
      puts "#{x}. #{item}"
      x += 1 
    end
  end
  
  def list_songs_by_genre
    x = 1
    genre_array = []
    song_array = []
    ultimate_array = []
    puts "Please enter the name of a genre:"
    user_input = gets.strip
    genre_object = Genre.find_or_create_by_name(user_input)
    genre_object.songs.each do |object|
      ultimate_array << "#{object.name},#{object.artist.name}"
    end
    ultimate_array.sort.each do |item|
      temp_array = item.split(",")
      puts "#{x}. #{temp_array[1]} - #{temp_array[0]}"
      x += 1
    end
  end
  
  def play_song 
    puts "Which song number would you like to play?"
    input = gets.strip.to_i
    if (1..Song.all.length).include?(input)
      song = Song.all.sort{ |a, b| a.name <=> b.name }[input - 1]
    end
    puts "Playing #{song.name} by #{song.artist.name}" if song
  end
end
  
  
    #def play_song
    #puts "Which song number would you like to play?"
    #x = gets.strip.to_i
    #binding.pry
    #if x.class == Integer && x > 0 && x <= self.play_song_array.length
      #song = self.play_song_array[x - 1].scan(/(?<=-\s).*?(?=\s-)/)[0]
      #artist = self.play_song_array[x - 1].scan(/(?<=\A).*?(?= -)/)[0] 
      #puts "Playing #{song} by #{artist}"
    #end
  #end