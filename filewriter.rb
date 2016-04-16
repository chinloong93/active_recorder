array = ['test1', 'test2', 'test3', 'test4', 'test5', 'test6', 'test7']
open('/Users/chinloong/Desktop/test.txt', 'w') do |f|
	f.puts "Hello, world!"
	array.each do |s|
		f.puts s
	end
end