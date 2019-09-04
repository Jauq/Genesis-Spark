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

#generates a random name with many optional properties
def genName(
	syllCount = rand(2..3),
	sym = false,
	conWt = [],
	vowWt = []
	)
	
	temp = {}
	temp[:rand] = rand(0..1)
	temp[:syll] = syllCount
	temp[:build] = []
	
	if temp[:rand] == 0
		temp[:build].push("vow")
		temp[:syll] -= 1
	elsif temp[:rand] == 1
		temp[:build].push("con")
	end
	
	while temp[:syll] > 0
		if temp[:build][-1] == "con"
			temp[:build].push("vow")
			temp[:syll] -= 1
		elsif temp[:build][-1] == "vow"
			temp[:build].push("con")
		end
	end
	
	temp[:rand] = rand(0..1)
	
	if temp[:rand] == 1
		temp[:build].push("con")
	end
	
	return temp[:build]
	
	#content here

end

loop do
	b = gets.chomp.to_s
	if b == ""
		puts genName
	else
		break
	end
end