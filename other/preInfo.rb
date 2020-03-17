def preInfo()
	msg = "\n  |  "

	msg += $g.planets[0].date()
	msg += " |  "

	msg += "Next Year "
	temp = $g.planets[0].diay - (($g.day - 1) % $g.planets[0].diay)
	if temp > 1
		msg += "in " + hl("#{temp}") + " Days "
	else
		msg += "Starts " + hl("Tomorrow") + " "
	end
	msg += " |  "

	msg += "\n"

	return msg
end