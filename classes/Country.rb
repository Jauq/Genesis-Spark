$baseCulture = {
	:anomalyFactor => 18, #1 in n chance that an anomaly will occur within the numbers below, this is alsothe number used to change 0 chances
	:avgFirstNameLength => 3, #avg syllables that is
	:avgLastNameLength => 3,
	:avgMiddleNameCount => 1,
    :symChance => [0, 0],
    :conDubChance => 0,
    :vowDubChance => 4,
	:conWt => [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    :vowWt => [1, 1, 1, 1, 1],
    :sylEnd => 0
}

$anomalyChance = [ #anomaly check will effect these symbols differently
    :sylEnd,
    :conDubChance,
    :vowDubChance
]

$anomalyProof = [ #anomaly check will ignore these symbols completely
    :symChance
]

class Country
	attr_accessor :culture, :details
	def initialize(baseCulture = $baseCulture)

		@culture = {}
		baseCulture.each {|key, value| @culture[key] = value} #borrows all culture values from the culture this one is based off of, default base is the $baseCulture variable

		@details = {}
		@details[:name] = ""
		@details[:nameOfResidence] = ""

    end
    
    def get(from = 0, type = "", sansAnomaly = false) #gets values from any variable
        if from == 1 or from == "culture"
            cultureGet(type, sansAnomaly)
        elsif from == 2 or from == "details"
            #detailsGet definition
        else
            return nil
        end
    end

	def cultureGet(type = "", sansAnomaly = false) #gets any value within the @culture variable allowing for the potential for anomalies

        product = nil

        if @culture[type].is_a? Integer #is this culture varaible an integer?
            temp = rand(0..1) #the random anomaly, if the anomaly chance happens
            if temp == 0
                temp = -1
            end
            temp2 = rand(1..@culture[:anomalyFactor])
            if temp2 == 1 and @culture[:anomalyFactor] > 0 and @culture[type] > -1 and not sansAnomaly and not $anomalyProof.include?(type) #will an anomaly occur
                if @culture[type] == 0
                    if not $anomalyChance.include?(type)
                        product = 1 #this variable is not a chance variable so setting to 1 is appropriate
                    else
                        product = @culture[:anomalyFactor] #this variable is a chance variable, :anomalyFactor is the new chance.
                    end
                else
                    product = @culture[type] + temp #an anomaly has occured, change it
                end
            else
                product = @culture[type] #this varaible stays the same way it came in.
            end
            
        elsif @culture[type].is_a? Array #is this culture variable an array?
            temp = rand(1..2)
		    if temp == 1
			    temp = 0.5
		    end
            product = []
            @culture[type].each do |z|
                temp2 = rand(1..@culture[:anomalyFactor])
                if temp2 == 1 and @culture[:anomalyFactor] > 0 and @culture[type][z] > -1 and not sansAnomaly and not $anomalyProof.include?(type)
                    if z == 0
                        if not $anomalyChance.include?(type)
                            product.push(1)
                        else
                            product.push(@culture[:anomalyFactor])
                        end
                    else
                        product.push((z * temp).to_i)
                    end
                else
                    product.push(z)
                end
            end

		end

		return product

	end

	def cultureMutate(factor)
		#mutates the culture randomly
	end

end