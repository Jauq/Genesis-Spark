#here is a template for genName, just to make manual weight distribution easier
#genName(rand(2..3), [0, 0], 1, 0, 4, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1])

@genName = {}
@genName[:cons] = ["b", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "r", "s", "t", "v", "w", "y", "z", "ch", "sh", "th"] #21 consonants (note the absence of c, q and x, as well as the addition of ch, sh and th)
@genName[:vows] = ["a", "e", "i", "o", "u"] #5 vowels

def genNameCons() #seemed useful, might delete later
    return @genName[:cons]
end

def genNameVows() #same, same
    return @genName[:vows]
end

#generates a completely random name
def genName(
	syllCount = rand(2..3), #the amount of true syllables the name will have (actual pronounciations will have varying syllable counts)
	symChance = [0, 0], #first is for ', second is for -, 1 out of n chance for symbol to appear, set to 0 for no chance
	symCount = 1, #limit to how many symbols can be used per name
	conDubChance = 0, #the chance a consonant section will have two consonants, 1 out of n chance, set to 0 for no chance
	vowDubChance = 4, #the chance a vowel section will have two vowels, 1 out of n chance, set to 0 for no chance
	conWt = [], #optional weight array to increase the odds of any particular consonant, must match temp[:cons] in length otherwise it will be ignored
	vowWt = [] #optional wight array to increase the odds of any particular vowel, must match temp[:vows] in length otherwise it will be ignored
	)

	temp = {}

	temp[:cons] = @genName[:cons]
	temp[:consNew] = [] #the actual array being used in the code, will fill out after adding weighted consonants

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
	
	temp[:vows] = @genName[:vows]
	temp[:vowsNew] = [] #the actual array being used in the code, will fill out after adding weighted vowels
	
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
	temp[:build] = [] #this array will hold the building block blueprint for the name being generated
	
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
	
	temp[:name] = "" #the final string which will be returned once the name is generated
	temp[:symWas] = true #this variable checks if a symbol was used during each loop around. Used to capitalize letters after symbols for fanciness
	temp[:buildMax] = temp[:build].count
	temp[:symCount] = 0
	
	while temp[:build].count > 0

		if temp[:build][0] == "con" #is next item in temp[:build] a consonant
			temp[:rand] = rand(1..conDubChance)
			if conDubChance >= 0 and temp[:rand] == 1 #will this consonant be a double consonant
				genNamePlaceLetter(temp, "con") #definition that places a letter into the name
				temp[:rand] = rand(1..symChance[0])
				if genNameIfSym(temp, symChance, symCount, 0) #definition that checks if a symbol should be allowed to be placed
					genNamePlaceSym(temp, "'", true) #definition that places a symbol into the name
				end
				genNamePlaceLetter(temp, "con")
			else #if this is not a double consonant
				temp[:rand] = rand(1..symChance[1])
				if genNameIfSym(temp, symChance, symCount, 1)
					#symbol chance but for not double consonant
					genNamePlaceSym(temp, "-")
				else
					genNamePlaceLetter(temp, "con")
				end
			end
			temp[:build].shift #removes the section in build so we can make a finite name
		elsif temp[:build][0] == "vow" #same as consonant but for vowel sections
			temp[:rand] = rand(1..vowDubChance)
			if vowDubChance >= 0 and temp[:rand] == 1
				genNamePlaceLetter(temp, "vow")
				temp[:rand] = rand(1..symChance[1])
				if genNameIfSym(temp, symChance, symCount, 1)
					genNamePlaceSym(temp, "-", true)
				end
				genNamePlaceLetter(temp, "vow")
			else
				temp[:rand] = rand(1..symChance[0])
				if genNameIfSym(temp, symChance, symCount, 0)
					genNamePlaceSym(temp, "'")
				else
					genNamePlaceLetter(temp, "vow")
				end
			end
			temp[:build].shift
		end
	
	end
	
	return temp[:name]

end

def genNameIfSym(temp, symChance, symCount, symType)
    symChance[symType] >= 0 and temp[:rand] == 1 and temp[:symCount] < symCount and not temp[:build].count >= temp[:buildMax] - 1 and not temp[:build].count <= 2
    #only activate if symbols are allowed, the symbol chance struck, there is less than the allowed amount of symbols,
    #and this section is not the first or the last one.
end

def genNamePlaceSym(temp, sym, shiftIt = false)
	temp[:name] += sym #adds symbol
	temp[:symCount] += 1
	temp[:symWas] = true
	if shiftIt #need to remove two sections (a vow and con) because this specific symbol creates a new syllable
		temp[:build].shift
		temp[:build].shift
	end
end

def genNamePlaceLetter(temp, type)
    a = nil
	if type == "con"
		a = :consNew
	elsif type == "vow"
        a = :vowsNew
    end
    if temp[:symWas]
        temp[:symWas] = false
        temp[:name] += temp[a].sample.capitalize
    else
        temp[:name] += temp[a].sample
    end
end