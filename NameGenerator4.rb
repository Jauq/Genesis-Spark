def generate_new_name(syllables = rand(3..5), alter = [16, 8, 30, 30, 18], active = [true, true, true, true, true])
	parts = []
	name = ""
	vows = ["a", "e", "i", "o", "u"]
	dub_vows = ["aa", "ae", "ai", "ee", "eu", "ie", "oa", "oi", "oo", "oo", "ue"]
	cons = ["b", "d", "f", "g", "h", "j", "k", "m", "n", "p", "t", "v", "y", "th", "ch"]
	fcons = ["s", "z", "sh", "zh"]
	bcons = ["l", "r", "w"]
	acons = cons + fcons + bcons
	
	rand1 = rand(0..1)
	rand2 = rand(0..1)
	temp = 0	
	syllables.times do
		temp += 1
		if rand1 == 0
			parts.push("vow")
			rand1 = 1
		elsif rand1 == 1
			parts.push("con")
			parts.push("vow")
			if temp == syllables
				if rand2 == 0
					parts.push("con")
				end
			end
		end
	end
	
	parts[0] = "f#{parts[0]}"
	parts[1] = "f#{parts[1]}"
	parts[parts.count-2] = "l#{parts[parts.count-2]}"
	parts[parts.count-1] = "l#{parts[parts.count-1]}"
	
	temp = 0
	temp2 = 0
	cap = 1
	sym = 0
	ladd = 0
	word = ""
	parts.count.times do
		
		if parts[temp].include? "con"
		
			temp2 = rand(1..alter[4])
			temp3 = rand(1..alter[3])
			if parts[temp] == "con" and temp2 == 1 and active[4] and sym == 0
				sym = 1
				name += "-"
				cap = 1
			else
				temp2 = rand(1..alter[1])
				if (temp2 > 1 or !active[1]) or parts[temp] == "lcon" or (parts[temp] == "fcon" and temp3 == 1 and active[3] and sym == 0)
					word = acons[rand(0...acons.count)]
					ladd = word.length
					if cap == 1
						cap = 0
						name += word.capitalize
					else
						name += word
					end
				else
					temp2 = rand(1..alter[2])
					if temp2 > 1 or !active[2]
						temp2 = rand(0..1)
						if temp == 0
							word = fcons[rand(0...fcons.count)] + cons[rand(0...cons.count)]
							ladd = word.length
							if cap == 1
								cap = 0
								name += word.capitalize
							else
								name += word
							end
						else
							word = cons[rand(0...cons.count)] + bcons[rand(0...bcons.count)]
							ladd = word.length
							if cap == 1
								cap = 0
								name += word.capitalize
							else
								name += word
							end
						end
					else
						word = fcons[rand(0...fcons.count)] + cons[rand(0...cons.count)] + bcons[rand(0...bcons.count)]
						ladd = word.length
						if cap == 1
							cap = 0
							name += word.capitalize
						else
							name += word
						end
					end
				end
			end
			
			if parts[temp] == "fcon"
				if temp3 == 1 and active[3] and sym == 0
					if sym == 0
						sym = 1
						name += "'"
						cap = 1
					end
				end
			end
			
		elsif parts[temp].include? "vow"
		
			temp2 = rand(1..alter[4])
			if parts[temp] == "vow" and temp2 == 1 and active[4] and sym == 0
				sym = 1
				name = name[0..-1*ladd]
				name += "-"
				cap = 1
			else
				temp2 = rand(1..alter[0])
				if temp2 > 1 or !active[0]
					word = vows[rand(0...vows.count)]
					ladd = word.length
					if cap == 1
						cap = 0
						name += word.capitalize
					else
						name += word
					end
				else
					word = dub_vows[rand(0...vows.count)]
					ladd = word.length
					if cap == 1
						cap = 0
						name += word.capitalize
					else
						name += word
					end
				end
			end
		
		end
		temp += 1
		
	end
	
	return name
	
end

print "Push enter to generate a new random name, type something and press enter to close."
names = []
loop do
	print " "
	a = gets.chomp
	words = a.split(' ')
	if a == ""
		print generate_new_name
	elsif words[0] == 'gen'
		if words[1] == 'new'
			temp = words[2].to_i
			names = []
			File.open("new_#{words[2]}_#{Time.now.strftime("%d%m%Y%H%M%S")}.txt", 'w+') do |f|
				while temp > 0
					gen_name = generate_new_name
					print "#{temp - 1} #{gen_name}"
					if !names.include? gen_name
						names.push(gen_name)
						temp -= 1
					else
						print " DUPLICATE"
					end
					puts ""
				end
				if words[3] == 'a'
					names = names.sort
				end
				if temp == 0
					for n in names do
						f.puts n
					end
				end
			end
			
		end
	else
		break
	end
end