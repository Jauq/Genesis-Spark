def getFiles(folder)
	a = Dir.glob("#{folder}/*.rb")
	print a
	puts ""

	a.each do |z|
		require_relative "#{z}"
	end
end

def getManyFiles(folderArray)
	folderArray.each do |x|
		getFiles(x)
	end
end

getManyFiles(
	["defs", "classes"]
)

$game = {}

def anyOfTheseInput(input, allows)
	if allows.include?(input)
		return true
	else
		return false
	end
end

loop do

	print "[]>>"
	input = gets.chomp.downcase.split(' ')

	if input.count > 0

		if anyOfTheseInput(input[0], ["end", "stop", "e"])

			break

		else

			puts "[Error] No Such Command Error."

		end

	end

end