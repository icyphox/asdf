def test
	# no args
	puts "no args mate"
end

def main
	test
	var1 = "kek9"
	test_args(var1)
end

def test_args(var)
	puts "#{var}"
end
# no ()
main
