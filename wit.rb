#grabs all .rb files in the folder named "defs"
a = Dir.glob("defs/*.rb")

print a
puts ""

#requires the code for files in the variable "a" so that we can use all of their definitions and classes
a.each do |z|
	require_relative "#{z}"
end

a = Dir.glob("classes/*.rb")

print a
puts ""

a.each do |z|
	require_relative "#{z}"
end

c = Country.new

#temporary test of def genName
loop do
	b = gets.chomp.to_s
	if b == ""
		print genName(rand(2..3), [10, 10], 1, 0, 4, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1], 2)
		#print "#{c.get(1, :vowWt, false)} "
	else
		break
	end
end