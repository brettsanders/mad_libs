require './reader'

puts "Welcome to Mad Libs in Ruby"
while true do
  puts
  puts "What do you want to do?"
  puts "Actions: create, fill, read, quit"
  
  user_response = gets.chomp
  case user_response

  when 'create'   
    puts "What name do you want for your new mad lib? (ex. 'a_bad_day')"
    user_input_title = gets.chomp
    puts
    puts "Alright, #{user_input_title} is a pretty good title. -_- "
    puts "Now, before creating the text for your MadLib"
    puts "You need to understand how it works."
    puts
    puts "Just type the story and whenever you want a blank, use (( ))"
    puts
    puts "For example: ((noun)) ((adjective)) ((verb))"
    puts
    puts "Or : ((a vehicle)) ((noun, past tense)) ((verb, ending -ing))"
    puts
    puts "Whatever you want ... These will be the blanks with instruction"
    puts "On what to fill in."
    puts 

    puts "Want to see a couple example stories? (yes or no)"
    user_input_yes_or_no = gets.chomp
    if user_input_yes_or_no == 'yes'
      puts "Ex. 1 : FAIRYTALE"
      puts "Once upon a time there was a ((noun)) who"
      puts "always ((verb, past tense)) and ((verb, past tense))"
      puts "and who LOVED to ((verb)) ((adjective)) ((type of food))."
      puts
      puts
      puts "Ex.2 : A BAD DAY"
      puts "Today I had a ((adjective)) BAD day. First, I had to eat ((number)) bowls of"
      puts "((gross food)). Next, I had to run ((number)) in the ((adjective)) rain"
      puts "to get to my ((adjective)) job on time because my ((adjective)) car was broke."
      puts
    end
    
    puts
    puts "Ok, we're ready to go ..."
    puts "... time to enter your ((adjective)) MadLib!"
    puts
    puts "Just type away and press return when you're done!"

    user_mad_lib = gets.chomp

    current_directory = Dir.pwd
    path_to_save = current_directory + "/raw_mad_libs/" + user_input_title + ".txt"
    File.open( path_to_save, "w" ) do |file|
      file.puts user_mad_lib
      file.close
    end
    puts "(creating new mad lib)"

  when 'fill'
    puts "Which mad lib do you want to fill out?"
    user_input = gets.chomp

    reader = Reader.new
    path_to_file = "#{user_input}.txt"

    reader.load_raw_mad_lib(path_to_file)
    reader.prepare_spots_for_user_to_fill_in
    reader.ask_user_for_words
    reader.fill_in_mad_lib
    
    if reader.user_want_to_save_mad_lib? == true
      puts "(filling in and saving mad lib)"
    else
      puts "(filling mad lib)"
    end

  when 'read'
    puts "Which MadLib do you want to open?"
    user_response = gets.chomp

    current_directory = Dir.pwd
    path_to_open = current_directory + "/saved_mad_libs/#{user_response}.txt"

    mad_lib_to_read = File.open(path_to_open, 'r').read
    puts mad_lib_to_read
  
  when 'quit'
    puts "(quitting program)"
    break

  else
    puts user_response + ' ... really?'
  end

end

# reader = Reader.new
# reader.load_raw_mad_lib('bad_day.txt')
# reader.prepare_spots_for_user_to_fill_in
# reader.ask_user_for_words
# reader.fill_in_mad_lib
# reader.user_want_to_save_mad_lib?


