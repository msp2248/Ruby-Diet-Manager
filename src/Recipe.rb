require './BasicFood'

class Recipe

  private
  # Create a new recipe object with a given name and empty arrray of foods
  def initialize(name)
    @foods = Array.new()
    @name = name
    @calories = 0;
  end

  public
  attr_reader :foods, :name, :calories
	
  # sets the amount of calories for the food, it is set after adding up the
  #calories of each food from the database
  def setcalories (num)
    @calories = num
  end		

  #puts object into a readable string, used for print and print all
  def toString	
    s = ""
    s += name + " " + calories.to_s  + "\n" + " "   
    foods.each do |food|
      s += food.toString + "\n" + " "
    end
    s.chop.chop
    s
  end	
end
