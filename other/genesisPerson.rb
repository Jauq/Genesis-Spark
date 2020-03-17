def genesisPersonDay
	temp = $g.people.count + 1
	if $g.day != $g.phaseNums[1]
		if $g.planets[0].diam >= 33
			if ($g.day - 1) % $g.planets[0].diam == 0
				newGenesisPerson
			elsif ($g.day - 1 + ($g.planets[0].diam / 2)) % $g.planets[0].diam == 0
				newGenesisPerson
			end
		else
			if ($g.day - 1) % $g.planets[0].diam == 0
				newGenesisPerson
			end
		end
	end
end

def newGenesisPerson(day = $g.day)
	ban = []
	$g.people.each do |person|
		ban.push(person.names[0])
	end
	temp = Person.new
	temp.names = []
	temp.names.push($g.n.newName(2, 0, 0, [], ban))
	temp.dates["dob"] = Date.new()
	temp.male = $g.phaseNums[2]
	temp.tags.push("genesis")
	if $g.phaseNums[2]
		$g.phaseNums[2] = false
	else
		$g.phaseNums[2] = true
	end
	$g.phaseNums[1] = day
	temp2 = (((day - 1) / $g.planets[0].diam.to_f).floor) % $g.planets[0].miay
	temp3 = $g.planets[0].mosNames[temp2]
	if temp3.start_with?("Month")
		$g.planets[0].mosNames[temp2] = temp.names[0]
	else
		$g.planets[0].mosNames[temp2] = "#{temp3} #{temp.names[0]}"
	end
	$g.people.push(temp)
	$g.phaseNums[0] -= 1
end