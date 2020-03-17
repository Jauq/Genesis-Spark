require_relative("getFiles.rb")

files = ["classes", "commands", "other"]

requireManyRubyFiles(files)

#----------#
# THE GAME #
#----------#

srand() #Seed the random. Leave blank for random seed.
puts "Seed #{ObjectSpace.each_object(Random).to_a[0].seed}"

puts "Genesis: Shard"
puts "V Cel.0.1"

puts "\nWelcome Cardinal"

$g = Game.new

loop do

	if $g.menu == "main"
		msg = "\n"
		msg += hl("New") + " Game\n"
		msg += hl("Load") + " Game\n"
		msg += hl("Exit") + " Game"
		input = getInput(msg)

		if $ia["new"].include?(input[0])
			$g.menu = "new"
		elsif $ia["load"].include?(input[0])
			puts "\nThe moment I can get this to work will be momentous indeed."
			# See Marshal class for saving states of variables. See my CoolBeans bot for best way to use it.
		elsif $ia["exit"].include?(input[0])
			temp = confirm?("\nAre you sure you want to exit?")
			if temp
				break
			end
		else
			error("No such command " + hl("#{input[0]}") + ".")
		end
	
	elsif $g.menu == "new"
		temp = confirm?("\nGo through the introduction?")
		name = "Cardinal"
		if temp
			print "\nWelcome Cardinal, "
			loop do
				input = getInput("what is your name?", false, false)
				temp = confirm?("\nAh so you call yourself #{input}?")
				if temp
					name = input
					break
				else
					print "\nWell then, "
				end
			end

		end
		puts "Welcome #{name}. Enjoy your planet."

		$g.cardinalName = name
		temp = $g.cardinalName
		if temp.end_with?("s")
			temp += "day"
		else
			temp += "sday"
		end
		$g.dotwNames[6] = temp
		$g.planets.push(Planet.new)

		$g.menu = "overview"

	elsif $g.menu == "overview"

		if $g.phase == 1
			if $g.phaseNums[0] > 0
				genesisPersonDay
			end
		end

		msg = ""
		msg += preInfo()
		if !$g.tut[0]
			$g.tut[0] = true
			msg += "You can type \"" + hl("help") + "\" for a list of commands."
		end
		input = getInput(msg)

		if input.count > 0
			if $ia["help"].include?(input[0])
				help(input)
			elsif $ia["exit"].include?(input[0])
				temp = confirm?("\nAre you sure you want to exit?")
				if temp
					break
				end
			elsif $ia["planet"].include?(input[0])
				planet(input)
			elsif $ia["people"].include?(input[0])
				people(input)
			elsif input[0] == "nd"
				if input.count > 1
					$g.day += input[1].to_i
				else
					$g.day += 1
				end
			else
				error("No such command " + hl("#{input[0]}") + ".")
			end
		else
			error("No input.")
		end

	else
		puts "no menu with string: #{$g.menu}"
		$g.menu = "main"

	end

end