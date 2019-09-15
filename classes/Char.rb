$baseDetails = {
    :firstName = "Tmp"
    :middleNames = ["Tmp"]
    :lastName = "Tmp"
    :birthCountry = 0
}

$baseStats = {
    :mhp = 20
}

class Char

    def initialize(baseStats = $baseStats, baseDetails = $baseDetails)

        @stats = {}
        baseStats.each {|key, value| @stats[key] = value}
        @details = {}
        baseDetails.each {|key, value| @details[key] = value}

    end

end