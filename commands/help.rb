#----------------#
# HELP FUNCTIONS #
#----------------#

def help(input = ["help"])

	if input.count == 1
		helpDisplay
	elsif input.count > 1
		helpDisplay(input)
	else
		error("No input in help function.")
	end

end

# DISPLAY HELP FUNCTION #

def helpDisplay(input = ["help", "help"])

	if $ia["help"].include?(input[1])
		puts "\n"
		puts hl("GENERAL HELP")
		helpLine("help", "help")
		helpLine("help", "exit")
		helpLine("help", "planet")
		helpLine("help", "people")
		helpLine("help", "help+")
	elsif $ia["planet"].include?(input[1])
		puts "\n"
		puts hl("PLANET HELP")
		helpLine("help", "planet")
		helpLine("planet", "help")
	elsif $ia["people"].include?(input[1])
		puts "\n"
		puts hl("PEOPLE HELP")
		helpLine("help", "people")
		helpLine("people", "help")
	else
		error("No help for " + hl("#{input[1]}") + ".")
	end

end

# HELPLINE FUNCTION #

def helpLine(main, sub)
	if main == "help"
		puts hl(">", "red") + " Type " + hl("help") + " to view this." if sub == "help"
		puts hl(">", "red") + " Type " + hl("exit") + " to exit the game." if sub == "exit"
		puts hl(">", "red") + " Type " + hl("planet") + " to view details on your planet." if sub == "planet"
		puts hl(">", "red") + " Type " + hl("people") + " to view a list of your people." if sub == "people"
		puts hl("+", "red") + " Additionally, typing any of these commands after " + hl("help") + " will display more specific help for those commands (excluding help and exit)." if sub == "help+"
	elsif main == "planet"
		puts hl(">", "red") + " Type " + hl("planet help") + " to view this." if sub == "help"
	elsif main == "people"
		puts hl(">", "red") + " Type " + hl("people help") + " to view this." if sub == "help"
	end
end