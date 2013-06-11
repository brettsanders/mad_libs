class Reader
  attr_reader :raw_mad_lib, :mad_lib_title, :finished_mad_lib, :array_of_fill_in_blank_pairs
  def initialize
    @raw_mad_lib = nil
    @mad_lib_title = nil
    # @hash_of_fill_in_blanks = {}
    @array_of_fill_in_blank_pairs = []
    @finished_mad_lib = nil
  end

  def load_raw_mad_lib(raw_mad_lib)
    @mad_lib_title = raw_mad_lib
    current_directory = Dir.pwd
    full_path_to_mad_libs = current_directory + '/raw_mad_libs/'
    @raw_mad_lib = File.open(full_path_to_mad_libs + raw_mad_lib, 'r').read

    # @raw_mad_lib = File.open("raw_mad_libs/#{raw_mad_lib}",'r').read
    @raw_mad_lib
  end

  def prepare_spots_for_user_to_fill_in
    array_from_scan = @raw_mad_lib.scan(/\(\((.*?)\)\)/)
    array_from_scan.each do |item|
      item << nil
    end
    @array_of_fill_in_blank_pairs = array_from_scan
    @array_of_fill_in_blank_pairs
  end

  def ask_user_for_words
    @array_of_fill_in_blank_pairs.each do |fill_in_blank_pair|
      puts "Please enter : " + fill_in_blank_pair[0]
      user_response = gets.chomp
      fill_in_blank_pair[1] = user_response
    end
    @array_of_fill_in_blank_pairs
  end

  def fill_in_mad_lib
    @finished_mad_lib = @raw_mad_lib
    @array_of_fill_in_blank_pairs.each do |pair| 
      @finished_mad_lib.sub!( "((#{pair[0]}))", pair[1] )
    end
    @finished_mad_lib
  end

  def user_want_to_save_mad_lib?
    puts "Do you want to save this mad lib as a new file? (yes or no)"
    user_input = gets.chomp
    if user_input == 'yes' 
      save_mad_lib
      true
    else
      puts "Ok, maybe next time."
      false
    end
  end

  def save_mad_lib
    puts "Saving mad lib"
    current_directory = Dir.pwd
    path_to_save = current_directory + '/saved_mad_libs/' + @mad_lib_title
    File.open(path_to_save, 'w') do |f|
      f.puts(@finished_mad_lib)
      f.close
    end
  end
end

# puts Dir.pwd

# reader = Reader.new
# reader.load_raw_mad_lib('bretts_mad_lib.txt')
# reader.prepare_spots_for_user_to_fill_in
# reader.ask_user_for_words
# reader.fill_in_mad_lib
# reader.user_want_to_save_mad_lib?

# reader = Reader.new
# reader.load_raw_mad_lib('bad_day.txt')
# reader.prepare_spots_for_user_to_fill_in
# reader.ask_user_for_words
# reader.fill_in_mad_lib
# reader.user_want_to_save_mad_lib?




# running through all code so far
# will put this into mad_lib_manager eventually
# puts "initializing reader instance"
# reader = Reader.new
# p reader
# # sleep 7

# puts "loading 'simple_story.txt"
# reader.load_raw_mad_lib('simple_story.txt')
# p reader
# # sleep 7

# puts "preapring spots for user to fill in (hash table)"
# reader.prepare_spots_for_user_to_fill_in
# p reader
# # sleep 7

# puts "asking user to fill in blanks"
# reader.ask_user_for_words
# p reader
# # sleep 7

# puts "filling in the blanks for finished mad lib"
# reader.fill_in_mad_lib
# p reader
# # sleep 7

# puts "asking reader to save"
# reader.want_to_save_mad_lib?
# p reader

# Need to store multiple of the same in hash
# { 1 => {"noun" => nil },
#   2 => {"adjective" => nil },
#   3 => {"adjective" => nil}
#   # etc
# }

# [["noun",nil],["adjective",nil]]
# what advantage to a hash?
# Well, I can lookup by the place
# But, since want place, it's an array
# So, what advantage to array of hashes?
# [{"noun" => "dog"},{"noun" => "cat"}]
# seems kind of dumb, because then i have to use array methods
# to drill down and use hash methods on single hashes! 

# If order matters so much, as does here, then better to use an array
# array of hashes ? 
# Yes, better this way
# array_of_hashes = [{"verb" => "run"},{"verb" => "dodge"},{"noun" => "woman"},{"verb" => "sing"}]
# since order matters, then this way is better

# I like this more than altering the string itself!



