class LogItem

public
#initializes a logitem from given date, and gives it an empty array of foods
def initialize(date)
  @foodList = Array.new()
  @date = date
end

public 
	
attr_reader :date, :foodList

#Adds a food to the foodsList
def add(food)
  foodList << food
end

#puts whole object into a user friendly string
def toString
  date
  s = date + "\n"
  foodList.each do |i|
    s += " " +  i + "\n"
  end
  s
end

end
