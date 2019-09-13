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

def inp(input, allows)
	return allows.include?(input)
end

loop do

	print "[     ]>>"
	input = gets.chomp.downcase.split(' ')

	if input.count > 0

		if inp(input[0], ["end", "stop", "e"])

			break

		elsif inp(input[0], ["clear", "c"])

			system "cls"

		elsif inp(input[0], ["ord"])

			if input.count > 1
				puts getOrdinal(input[1])
			else
				puts getOrdinal(rand(0..100))
			end

		else

			puts "[Error] No Such Command Error."

		end

	end

end