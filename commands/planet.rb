#------------------#
# PLANET FUNCTIONS #
#------------------#

def planet(input = ["planet"])

	if input.count == 1
		planetDisplay
	elsif input.count >= 2
		planetDisplay(input)
	else
		error("No input in planet function.")
	end

end

# DISPLAY PLANET FUNCTION #

def planetDisplay(input = ["planet", "planet"])

	if $ia["help"].include?(input[1])
		helpDisplay(["help", "planet"])
	elsif $ia["planet"].include?(input[1])
		planetFullInfo()
	else
		error("No subcommand " + hl("#{input[1]}") + " for " + hl("planet") + ".")
	end

end

# UNIQUE PLANET FUNCTIONS #

def planetFullInfo()
	puts "\n"
	puts hl("PLANET INFORMATION")
	puts "\n\t\tPlanet " + hl($g.planets[0].name)
	puts "\tHome of the "+ hl($g.planets[0].residence)
	if $g.planets[0].tilt < 5
		puts "\tThe planet doesn't have an influential tilt."
	else
		puts "\tThe planet has a tilt of " + hl($g.planets[0].tilt.to_s) + " degrees."
	end
	puts "\n" + hl("CHRONOLOGICAL DETAILS")
	print "\n\tThere are " + hl($g.planets[0].diay.to_s) + " days in a year, "
	print hl($g.planets[0].miay.to_s) + " months in a year and each of those months have "
	puts hl($g.planets[0].diam.to_s) + " days."
	puts "\tThe months are named:"
	puts "\n"
	temp = 0
	$g.planets[0].mosNames.count.times do |z|
		temp = $g.planets[0].mosNames[z].length > temp ? $g.planets[0].mosNames[z].length : temp
	end
	$g.planets[0].mosNames.count.times do |z|
		print "\t" + hl($g.planets[0].mosNames[z])
		puts ",#{" " * (temp - $g.planets[0].mosNames[z].length)} The " + hl("#{getOrdinal(z + 1)}") + " month of the year."
	end
	puts hl("\nSCROLL UP FOR FULL DETAILS")
end