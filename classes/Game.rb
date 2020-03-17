#------------# Manages all game stuff.
# GAME CLASS # Potentially acts as the only global variable. Contains all other objects.
#------------#

class Game

	attr_accessor :n, :menu, :tut, :phase, :phaseNums, :cardinalName, :dotwNames, :planets, :people, :day

	def initialize()

		#n; the generic name generator
		@n = NameGenerator.new

		#menu
		@menu = "main"

		#tut; tutorial stuff, 0 is for first "help" note
		@tut = [false]

		#phase
		@phase = 1

		#phaseNums; 0 is max genesisPeople, 1 is day of previous genesisPerson, 2 is male gender of first genesisPerson
		@phaseNums = [18, 0, true]

		#cardinalName
		@cardinalName = "Cardinal"
		
		#dotwNames; 6 will be modified to the name of the player
		@dotwNames = ["Monoday", "Duoday", "Triday", "Quaday", "Pentday", "Hexday", "temp"]

		#planets
		@planets = []

		#people
		@people = []

		#day
		@day = 1

	end

	def dotw(day = @day, number = false)
		temp = ((day - 1) % 7)
		if !number
			return "#{@dotwNames[temp]}"
		else
			return temp
		end
	end

end