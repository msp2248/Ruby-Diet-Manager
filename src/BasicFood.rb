class BasicFood
  private

  # initialized a basic food with a given name and amount of calories

  def initialize(name,calories)
    @name = name
    @calories = calories
  end

  public 
  attr_reader :name, :calories

  #turns the food object into a readable string that shows its fields
  def toString 
    s = ""
    s += name  + " "  + calories.to_s
  end
end
