#--------------#
# INPUT ARRAYS #
#--------------#

$ia = {
	"exit" => ["exit", "end", "e", "stop"],
	"help" => ["help", "hel", "he", "h", "assistance", "assist", "guide"],
	"info" => ["info", "inf", "in", "i", "information", "details", "detail", "specifics"],
	"yes" => ["yes", "ye", "y", "yep", "yeah", "definitely", "sure", "ci", "cí"],
	"no" => ["no", "n", "nope", "nah", "nada", "negative", "never"],
	"new" => ["new", "ne", "instantiate"],
	"load" => ["load", "loa", "lo", "l", "remember"],

	"planet" => ["planet", "plane", "plan", "pla", "pl", "p", "world", "worl", "wor", "wo", "w", "realm"],
	"map" => ["map", "ma", "m", "location", "loc"],
	"people" => ["persons", "person", "perso", "pers", "per", "people", "peopl", "peop", "peo", "pe", "peeps", "peep", "units", "unit", "uni", "un", "u", "residence", "greyfolk"],
	"calendar" => ["calendar", "calenda", "calend", "calen", "cale", "cal", "ca", "c", "dates"],
	"year" => ["year", "revolution", "rev", "r"],
	"tasks" => ["missions", "mission", "missio", "missi", "miss", "mis", "mi", "tasks", "task", "tas", "ta", "t"]
} # when adding new arrays be sure there are no duplicate keywords anywhere

#-------------------#
# GENERAL FUNCTIONS #
#-------------------#

def confirm?(message = "\n", assume = "undecided")
	# Prompts the user to answer a yes or no question, returns the answer in boolean form.
	loop do
		puts message
		print hl("Y/N > ", "cyan")
		input = gets.chomp.downcase
		if $ia["yes"].include?(input)
			return true
		elsif $ia["no"].include?(input)
			return false
		else
			if assume == "yes"
				return true
			elsif assume == "no"
				return false
			else
				error("Please make a decision.")
			end
		end
	end
end

def getInput(message = "\n", downcase = true, split = true, splitter = " ")
	puts message
	print hl("\n[Input]> ", "cyan")
	input = gets.chomp
	if downcase
		input = input.downcase
	end
	if split
		input = input.split(splitter)
	end
	return input
end

def notice(message = "\n")
	puts message
	print "\nPress " + hl("enter", "cyan") + " to continue. "
	gets.chomp
end

def error(errorCode = "General input error.")
	puts "\n[" + hl(" ERROR ", "red") + "]"
	puts errorCode
end

def hl(text, color = "yellow")
	if color == "yellow"
		return text.yellow
	elsif color == "red"
		return text.red
	elsif color == "cyan"
		return text.cyan
	elsif color == "green"
		return text.green
	else
		return text
	end
end