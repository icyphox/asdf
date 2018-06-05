require "fileutils"

path = ARGV.first

file_contents = File.read(path)
file_contents.puts
