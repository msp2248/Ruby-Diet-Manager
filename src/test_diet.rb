require 'test/unit'
require './BasicFood'
require './Recipe'
require './FoodDB'
class TestBasicFood < Test::Unit::TestCase

  def test1
    food = BasicFood.new('Avocado', 225)
    recipe = Recipe.new("BLT")

    assert( food.calories == 225, 'Failure, actual ammount is 225' )
    assert( food.name == 'Avocado', 'Failure, actual name is Avocado' )
    assert( recipe.name == 'BLT', 'Actual name is BLT' )
  end

  def testFoodDB
    db = FoodDB.new("FoodDB.txt")
    assert(db.getDB["Banana"].calories == 100, "Banana should have 100 cal")
    assert(db.getDB["BLT"].calories == 360, "BLT should have 390 cal")
  end

  def testAdd
    db = FoodDB.new("FoodDB.txt")
    db.add(Recipe.new("Banana Chicken"))
    db.add(BasicFood.new("Vegan Eggs",90))
    assert(db.getDB["Banana Chicken"] != nil, "Banana chicken is in the database")
    assert(db.getDB["Vegan Eggs"] != nil, "Vegan eggs is in the database")

  end
end
