$personClassNames = [
	"Vagrant"
]

#--------------#
# PERSON CLASS #
#--------------#

class Person

	attr_accessor :active, :male, :names, :dates, :class, :lvl, :exp, :action, :tags

	def initialize()

		#active; if this person can be commanded. If a dod is present, person is assumed dead.
		@active = true

		#male; gender in boolean form. true = male, false = female
		@male = rand(0..1) == 0 ? true : false

		#names; stack as many as you want. The code can identify the first and last names by index.
		@names = [$g.n.newName(2), $g.n.newName(2), $g.n.newName(2)]

		#dates; important dates for the person.
		@dates = {"dob" => Date.new()}

		#class
		@class = 0

		#lvl
		@lvl = 1

		#exp
		@exp = 0

		#action
		@action = false

		#tags
		@tags = []

	end

	def quickName(people, ban)
		temp = 0
		i = 0
		people.each do |person|
			if person.names[0] == @names[0] and i != ban
				if person.names[-1] == @names[-1]
					temp = 2
				else
					temp = temp < 1 ? 1 : temp
				end
			end
		i += 1
		end
		if temp > 0 and @names.count < 2
			temp = 0
		end
		if temp == 0
			return @names[0]
		elsif temp == 1
			return @names[0] + " " + @names[-1][0] + "."
		elsif temp == 2
			#puts "uh oh"
			return @names[0] + " " + @names[-1]
		end
	end

	def className
		return $personClassNames[@class]
	end

end