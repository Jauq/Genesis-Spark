#------------# Dates important to people or countries (or other person based entities)
# DATE CLASS # Also if that person will observe the date and under what circumstances.
#------------#

class Date

	attr_accessor :day, :doty, :mood, :imp, :likes

	def initialize(day = $g.day, mood = 1, imp = 2, likes = [])

		#day; the day that it happened.
		@day = day

		#doty; the day of the year that it happened. For reoccurance ease.
		@doty = $g.planets[0].doty(day)

		#mood; the mood the date should bring, 1 = happy, celebretory, 0 = sad, grievance.
		@mood = mood

		#imp; importance from 0 to 3, 0 = never observed, 1 = acknowledged, 2 = may observe, 3 = always observed.
		@imp = imp

		#likes; if imp is 1 or 2, the person needs these likes high enough to acknowledge or observe the date respectively.
		@likes = likes

	end

	def observes?(person)
		#put the code here that checks the likes of the person and determines if they will acknowledge or observe the day.
		#account for if the DATE ITSELF is listed in the likes, even if halloween is a 3, a person with 0 like of the date will not observe.
		#Return true if it will be observed and false otherwise.

		#Obviously likes of people have not been added yet, but this will be helpful once it is. For now though:

		if @imp == 2 or @imp == 3
			return true
		else
			return false
		end

	end

end