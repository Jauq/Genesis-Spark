def getOrdinal(number = 0, upcase = false)
	#returns the numbered-ordinal version of the int given as a string (lowercase unless upcase is set to true)

    ordinal = ""

    if !number.is_a? Integer
        number = number.to_i
    end

    if number < 0
        number = number * -1
        ordinal += "-"
    end

    if number < 10
        if number == 1
            ordinal += "1st"
        elsif number == 2
            ordinal += "2nd"
        elsif number == 3
            ordinal += "3rd"
        else
            ordinal += "#{number}th"
        end
    elsif number >= 10
        if number.to_s[-2, 1] == "1"
            ordinal += "#{number}th"
        elsif number.to_s[-1, 1] == "1"
            ordinal += "#{number}st"
        elsif number.to_s[-1, 1] == "2"
            ordinal += "#{number}nd"
        elsif number.to_s[-1, 1] == "3"
            ordinal += "#{number}rd"
        else
            ordinal += "#{number}th"
        end
    end

    if upcase
        return ordinal.upcase
    else
        return ordinal
    end

    return ordinal

end