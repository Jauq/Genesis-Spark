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
	symChance = [0, 0], #first is for ', second is for -
	conDubChance = 8,
	vowDubChance = 4,
	conWt = [],
	vowWt = []
	)

	temp = {}

	temp[:cons] = ["b", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "r", "s", "t", "v", "w", "y", "z", "ch", "sh", "th"] #21 consonants
	temp[:consNew] = []

	if conWt != []
		if conWt.count == temp[:cons].count
			conWt.count.times do |z|
				conWt[z].times do |z2|
					temp[:consNew].push(temp[:cons][z])
				end
			end
		else
			temp[:consNew] = temp[:cons]
		end
	else
		temp[:consNew] = temp[:cons]
	end
	
	temp[:vows] = ["a", "e", "i", "o", "u"] #5 vowels
	temp[:vowsNew] = []
	
	if vowWt != []
		if vowWt.count == temp[:vows].count
			vowWt.count.times do |z|
				vowWt[z].times do |z2|
					temp[:vowsNew].push(temp[:vows][z])
				end
			end
		else
			temp[:vowsNew] = temp[:vows]
		end
	else
		temp[:vowsNew] = temp[:vows]
	end
	
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
	
	temp[:name] = ""
	
	while temp[:build].count > 0
	
		if temp[:build][0] == "con"
			temp[:rand] = rand(1..conDubChance)
			if conDubChance != 0 and temp[:rand] == 1
				temp[:name] += temp[:consNew].sample
				temp[:rand] = rand(1..symChance[0])
				if symChance != 0 and temp[:rand] == 1
					temp[:name] += "'"
				end
				temp[:name] += temp[:consNew].sample
			else
				temp[:name] += temp[:consNew].sample
			end
			temp[:build].shift
		elsif temp[:build][0] == "vow"
			temp[:rand] = rand(1..vowDubChance)
			if vowDubChance != 0 and temp[:rand] == 1
				temp[:name] += temp[:vowsNew].sample
				temp[:rand] = rand(1..symChance[1])
				if symChance != 0 and temp[:rand] == 1
					temp[:name] += "-"
				end
				temp[:name] += temp[:vowsNew].sample
			else
				temp[:name] += temp[:vowsNew].sample
			end
			temp[:build].shift
		end
	
	end
	
	return temp[:name].capitalize

end

loop do
	b = gets.chomp.to_s
	if b == ""
		puts genName(rand(2..3), [3, 0], 8, 4, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
	else
		break
	end
end