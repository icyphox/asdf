require 'readline'
 
while input = Readline.readline("> ", true)
  break                       if input == "exit"
  puts Readline::HISTORY.to_a if input == "hist"
 
  # Remove blank lines from history
  Readline::HISTORY.pop if input == ""
 
  system(input)
end
