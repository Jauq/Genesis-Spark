#grabs all .rb files in the folder named "defs"
a = Dir.glob("defs/*.rb")

print a
puts ""

#requires the code for files in the variable "a" so that we can use all of their definitions and classes
a.each do |z|
	require_relative "#{z}"
end

#test to see if definition "smack" from "test.rb" works.
puts smack

#stops the program from closing itself out, waiting for user to press enter.
gets.chomp