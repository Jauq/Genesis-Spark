=begin
$nid = 0
def nextId
	$nid += 1
	return $nid - 1
end
alias nid nextId

def findObjectById(id)
	temp = ObjectSpace.each_object(Detail).to_a
	found = -1
	temp.each do |object|
		if object.id == id
			found = object
		end
	end
	return found
end
alias fobid findObjectById
=end