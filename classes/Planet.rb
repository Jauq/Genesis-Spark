#--------------# 
# PLANET CLASS #
#--------------#

class Planet

	attr_accessor :name, :residence, :miay, :diay, :diam, :mosNames, :adultAge, :tilt

	def initialize()

		#name
		@name = "#{$g.n.newName}"

		#residence
		temp = @name
		loop do
			if temp.end_with?("a", "e", "i", "o", "u")
				temp = temp[0...temp.length - 1]
			else
				break
			end
		end
		temp2 = ["ians", "ese", "on", "ites", "ines", "ok", ""]
		temp += temp2[rand(0...temp2.count)]
		@residence = temp

		#miay
		@miay = rand(6..14)

		#diay
		if @miay <= 9
			@diay = (rand(33..47) * @miay)
		else
			@diay = (rand(19..32) * @miay)
		end

		#diam
		@diam = (@diay/@miay).to_i

		#mosNames
		@mosNames = []
		@miay.times do |i|
			@mosNames.push("Month #{i + 1}")
		end

		#adultAge
		temp = (365 * 16)
		temp = (temp / @diay).floor
		@adultAge = temp

		#tilt
		@tilt = rand(-4.0..48.0).round(1)

	end

	def dotm(day = $g.day)
		return ((day - 1) % @diam) + 1
	end

	def doty(day = $g.day)
		return ((day - 1) % @diay) + 1
	end


	def moty(day = $g.day, number = false)
		if !number
			return "#{@mosNames[(((day - 1) % @diay)/@diam).floor]}"
		else
			return (((day - 1) % @diay)/@diam).floor
		end
	end

	def year(day = $g.day)
		((day - 1)/@diay).floor + 1
	end

	def date(day = $g.day, putsDotw = true)
		temp = ""
	  if putsDotw
			temp += hl("#{$g.dotw(day)}") + ", the "
		else
			temp += "The "
		end
		temp += hl("#{getOrdinal(self.dotm(day))}") + " of "
		temp += hl(self.moty(day)) + ", "
		temp += "Year " + hl(self.year(day).to_s) + " "
		return temp
	end

end