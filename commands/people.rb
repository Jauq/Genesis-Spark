#------------------#
# PEOPLE FUNCTIONS #
#------------------#

def people(input = ["people"])

	if input.count == 1
		peopleDisplay
	elsif input.count >= 2
		peopleDisplay(input)
	else
		error("No input in people function.")
	end

end

# DISPLAY PEOPLE FUNCTION #

def peopleDisplay(input = ["people", "people"])

	if $ia["help"].include?(input[1])
		helpDisplay(["help", "people"])
	elsif $ia["people"].include?(input[1])
		peopleList
	elsif $ia["info"].include?(input[1])
		if input.count < 3
			loop do
				peopleList
				msg = "\nType the id number of the person you wish to see details for."
				input = getInput(msg)
				peopleDisplay(["people", "info", input[0]])
				break
			end
		else
			peopleFullInfo(input[2].to_i)
		end
	else
		error("No subcommand " + hl("#{input[1]}") + " for " + hl("people") + ".")
	end

end

# YOONEEK PEOPLE FUNCTION #

def personAge(id, list = $people)
	count = 0
	list.each do |person|
		if count + 1 == id
			return (($g.day - person.dates["dob"].day) / $g.planets[0].diay.floor)
		end
		count += 1
	end
end

def peopleList(list = $g.people)
	puts hl("\nLIST OF PEOPLE")
	temp = [0, 0, 0, 0]
	i = 0
	list.each do |person|
		if person.active
			a = (i + 1).to_s.length
			temp[0] = a > temp[0] ? a : temp[0]
			a = person.quickName(list, i).length
			temp[1] = a > temp[1] ? a : temp[1]
			a = person.lvl.to_s.length
			temp[2] = a > temp[2] ? a : temp[2]
			a = person.className.length
			temp[3] = a > temp[3] ? a : temp[3]
		end
		i += 1
	end
	i = 0
	list.each do |person|
		if person.active
			print "[" + hl("#{" " * (temp[0] - (i + 1).to_s.length)}#{i + 1}") + "] "
			print hl(person.quickName(list, i)) + "#{" " * (temp[1] - person.quickName(list, i).length)} | "
			print hl("Lv #{" " * (temp[2] - person.lvl.to_s.length)}#{person.lvl} ")
			print hl("#{" " * (temp[3] - person.className.length)}#{person.className}") + " | "
			if person.action
				print hl("Occupied", "red")
			else
				print hl("Awaiting Task", "cyan")
			end
			puts ""
		end
		i += 1
	end
end

def peopleFullInfo(id = 0, list = $g.people)
	count = 0
	check = 0
	list.each do |person|
		if count + 1 == id
			check += 1
			puts hl("\nCOMPLETE DETAILS")
			fullName = ""
			person.names.count.times do |z|
				if z > 0
					fullName += " "
				end
				fullName += person.names[z]
			end
			if person.active
				puts "\t\t[" + hl((count + 1).to_s) + "] " + hl("#{fullName}")
			elsif person.dates.has_key?("dod")
				puts "\t\t[" + hl((count + 1).to_s) + "] " + hl("#{fullName}", "red") + " - " + hl("DECEASED", "red")
			else
				puts "\t\t[" + hl((count + 1).to_s) + "] " + hl("#{fullName}") + " - " + hl("MISSING", "red")
			end
			print "\n"
			temp = person.male ? "Male" : "Female"
			puts "\tGender:   " + hl("#{temp}")
			puts "\tAge:      " + hl(personAge(id, list).to_s)
			puts "\tBirthday: " + $g.planets[0].date(person.dates["dob"].day, false)
			if person.dates.has_key?("dod")
				puts "\tDied On:  " + $g.planets[0].date(person.dates["dod"].day, false)
			end
			print "\n"
			puts "\tClass:    " + hl(person.className)
			puts "\tLevel:    " + hl(person.lvl.to_s)
			puts "\tEXP:      " + hl(person.exp.to_s) + " / ???"
			print "\n"
			temp = ""
			if person.action
				temp = hl("Occupied", "red")
			else
				temp = hl("Awaiting Task", "cyan")
			end
			puts "\tTask:     " + temp
		end
		count += 1
	end
	if check == 0
		print "\nNo person with id [" + hl(id.to_s) + "] found."
		if id > 0 and id - $g.people.count < 30
			puts " Try waiting a little while."
		else
			puts ""
		end
	end
end