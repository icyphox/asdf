#!/usr/bin/ruby -w

# learn BEGIN
BEGIN {
	puts "initializing ruby"
}

puts "hello";

# heredocs

print <<EOF
here docs are lame desu
EOF

# learn END

END {
	puts "end is here"
}

= begin
block comments
whoa
= end

# classes
class Test
	@@test = 0
end

test1 = Test.new
# i think classes are stupid, gonna skip it

# conditionals (yeah i know but whatever)
if 1 > 2
	puts "1 is greater than 2"
elsif 1 == 2
	puts "1 is equal to two"
else
	puts "1 is less than two"
end

$check = 1
print "check is true" if $check # hmm, p cool

unless 1 > 2  # can't grok very well :v
	puts "kek"
else
	puts "topkek"
end

# cases
lulz = 5
case lulz
when 0 .. 2
	puts "asdf"
when 3 .. 6
	puts "lolz"
else
	puts "okae"
end

# loops
while 1 > 2 do
	puts "roflcopter"
end

until 1 < 2 do
	puts "poggers"
end

for i in 1..5
	puts "#{i}"
end

# something new here
(0..5).each do |i|
	puts "#{i}"
end
