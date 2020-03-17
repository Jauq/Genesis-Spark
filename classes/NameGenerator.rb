#---------------------# Generates names. Can be edited to generate name "styles" for countries or species.
# NAMEGENERATOR CLASS #
#---------------------#

class NameGenerator

	def initialize()

		@details = {}

		#cons | All consonants that can be generated. Add duplicates for higher odds. Add vowels for weirdness.
		@details["cons"] = ["b", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "r", "s", "t", "v", "w", "y", "z", "ch", "sh", "th"]
		
		#conDub | The chance, 1 out of n, to generate two consonants together. 0 means never.
		@details["conDub"] = 0

		#vows | All vowels that can be generated. Add duplicates for higher odds. Add consonants for weirdness.
		@details["vows"] = ["a", "e", "i", "o", "u"]

		#vowDub | The chance, 1 out of n, to generate two vowels together. 0 means never.
		@details["vowDub"] = 0

		#syms | All symbols that can be generated. Add duplicates for higher odds.
		@details["syms"] = ["-", "'"]

		#symChance | The chance, 1 out of n, for a symbol to replace a syllable.
		@details["symChance"] = 0

		#symCount | The amount of symbols allowed in a name.
		@details["symCount"] = 0

		#bannedWords | A name that contains any of these will be tossed, and a new one generated.
		@details["bannedWords"] = []

		#bannedNames | A name that matches completely with any of these will be tossed, and a new one generated.
		@details["bannedNames"] = ["A", "E", "I", "O", "U"]
	end

	def newName(
		sylCount = rand(2..3), #Roughly how many pronouncable syllables the name has.
		sylBeg = 0, #0 = 50/50 con/vow, 1 = con, 2 = vow
		sylEnd = 0, #0 = 50/50 con/vow, 1 = con, 2 = vow
		tempBannedWords = [], #These words are only banned for this generation.
		tempBannedNames = []  #These names are only banned for this generation.
	)

		loop do #This loop is only here to catch banned words and names

			temp = {}

			temp["rand"] = rand(1..2)
			temp["syl"] = sylCount #Keeps track of remaining syllables
			temp["build"] = [] #This array contains the name building blocks

			#Determines the first block.
			if sylBeg == 1
				temp["build"].push("con")
			elsif sylBeg == 2
				temp["build"].push("vow")
				temp["syl"] -= 1
			else
				if temp["rand"] == 1
					temp["build"].push("con")
				else
					temp["build"].push("vow")
					temp["syl"] -= 1
				end
			end

			#Adds remaining blocks.
			while temp["syl"] > 0
				if temp["build"][-1] == "con"
					temp["build"].push("vow")
					temp["syl"] -= 1
				elsif temp["build"][-1] == "vow"
					temp["build"].push("con")
				end
			end

			temp["rand"] = rand(1..2)

			#Determines last block.
			if (temp["rand"] == 1 and sylEnd == 0) or sylEnd == 1
			temp["build"].push("con")
			end

			temp["name"] = "" #The name. Will be returned.
			temp["buildMax"] = temp["build"].count #Max build blocks, prevents symbols from being first.
			temp["symWas"] = true #Used to capitalize letters after symbols.
			temp["symCount"] = 0 #Prevents more than the allowed amount of symbols.

			#Actually building the name.
			while temp["build"].count > 0

				if temp["build"][0] == "con"

					temp["rand"] = @details["conDub"] > 0 ? rand(1..@details["conDub"]) : 0
					if temp["rand"] != 1
						temp["rand"] = @details["symChance"] > 0 ? rand(1..@details["symChance"]) : 0
						if canPlaceSym(temp)
							placeLetter(temp, "sym")
						else
							placeLetter(temp, "con")
						end
					else
						temp["rand"] = @details["symChance"] > 0 ? rand(1..@details["symChance"]) : 0
						if canPlaceSym(temp)
							placeLetter(temp, "sym")
						else
							placeLetter(temp, "con")
							placeLetter(temp, "con")
						end
					end
					temp["build"].shift

				elsif temp["build"][0] == "vow"

					temp["rand"] = @details["vowDub"] > 0 ? rand(1..@details["vowDub"]) : 0
					if temp["rand"] != 1
						temp["rand"] = @details["symChance"] > 0 ? rand(1..@details["symChance"]) : 0
						if canPlaceSym(temp)
							placeLetter(temp, "sym")
						else
							placeLetter(temp, "vow")
						end
					else
						temp["rand"] = @details["symChance"] > 0 ? rand(1..@details["symChance"]) : 0
						if canPlaceSym(temp)
							placeLetter(temp, "sym")
						else
							placeLetter(temp, "vow")
							placeLetter(temp, "vow")
						end
					end
					temp["build"].shift

				end

			end

			#Determining if it contains banned articles.
			temp["banCheck"] = 0
			@details["bannedWords"].each do |word|
				if temp["name"].downcase.include?(word)
					temp["banCheck"] += 1
				end
			end
			@details["bannedNames"].each do |name|
				if temp["name"] == name
					temp["banCheck"] += 1
				end
			end
			tempBannedWords.each do |word|
				if temp["name"].downcase.include?(word)
					temp["banCheck"] += 1
				end
			end
			tempBannedNames.each do |name|
				if temp["name"] == name
					temp["banCheck"] += 1
				end
			end

			#Return if all is well.
			if temp["banCheck"] == 0
				return temp["name"]
				break
			end

		end

	end

	def canPlaceSym(temp)
		temp["rand"] == 1 and temp["symCount"] < @details["symCount"] and temp["build"].count != temp["buildMax"] and temp["build"].count > 1 and not temp["symWas"]
	end

	def placeLetter(temp, type)
    a = nil
		if type == "con"
			a = "cons"
		elsif type == "vow"
			a = "vows"
		elsif type == "sym"
			a = "syms"
			temp["symWas"] = true
			temp["symCount"] += 1
		end
		if temp["symWas"] and type != "sym"
				temp["symWas"] = false
				temp["name"] += @details[a].sample.capitalize
		else
				temp["name"] += @details[a].sample
		end
	end
end