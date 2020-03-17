#--------------# String class modifications courtesy of https://stackoverflow.com/questions/1489183/colorized-ruby-output
# STRING CLASS #
#--------------#

class String
	def black;         "\e[30m#{self}\e[0m" end
	def red;           "\e[31m#{self}\e[0m" end
	def green;         "\e[32m#{self}\e[0m" end
	def yellow;        "\e[33m#{self}\e[0m" end
	def blue;          "\e[34m#{self}\e[0m" end
	def magenta;       "\e[35m#{self}\e[0m" end
	def cyan;          "\e[36m#{self}\e[0m" end
	def gray;          "\e[37m#{self}\e[0m" end
	def grey;          "\e[37m#{self}\e[0m" end

	def blackBg;       "\e[40m#{self}\e[0m" end
	def redBg;         "\e[41m#{self}\e[0m" end
	def greenBg;       "\e[42m#{self}\e[0m" end
	def yellowBg;      "\e[43m#{self}\e[0m" end
	def blueBg;        "\e[44m#{self}\e[0m" end
	def magentaBg;     "\e[45m#{self}\e[0m" end
	def cyanBg;        "\e[46m#{self}\e[0m" end
	def grayBg;        "\e[47m#{self}\e[0m" end
	def greyBg;        "\e[47m#{self}\e[0m" end

	def bold;          "\e[1m#{self}\e[21m" end
	def boldAlt;       "\e[1m#{self}\e[22m" end
	def italic;        "\e[3m#{self}\e[23m" end
	def underline;     "\e[4m#{self}\e[24m" end
	def blink;         "\e[5m#{self}\e[25m" end
	def reverseColor;  "\e[7m#{self}\e[27m" end
end