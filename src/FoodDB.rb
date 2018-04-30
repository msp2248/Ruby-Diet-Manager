
require'./Recipe'
require'./BasicFood'
class FoodDB

  # gets a hashmap from a csv file of foods
  private
  def initialize (filename)
    @db = createDB(filename)
  end
	

  public 
  attr_reader :db
  
  #gets the database hash of foods
  def getDB
    @db
  end

  # helper to initialize the hashmap from csv file
  def createDB(filename)
    db = Hash.new()	
    csvfile = File.open(filename, "r")
    csvfile.each_line do |line|
      arr = line.split(",")
      if arr[1] == "b"
	db[arr[0]] =  BasicFood.new(arr[0], arr[2].to_i)
      end

      # if object is a recipe it adds up the calories of all
      #items in the foods list
      if arr[1] == "r"
	r = Recipe.new (arr[0])
	total =0
	arr.shift
	arr.shift
	arr.each do |elt|
	  if (db.has_key?(elt))
	    r.foods << db[elt]
	    total += db[elt].calories
	  end		
	end
	r.setcalories(total)
	db[r.name] = r
      end
    end
    db
  end

  #adds an object to the database
  def add(r)
    db[r.name] = r
  end
	

  #saves the database into a given file in csv format
  def toFile(filename)	
    file = File.open(filename, 'w')
    db.each_key do |name|
      s = ""
      if (db[name].class == BasicFood)
      	s+= name + ",b," + db[name].calories.to_s
      end
      if (db[name].class == Recipe)
      	s = name + ",r"
	db[name].foods.each do |food|
	  s += "," + food.name
	end
      end
      s += "\n"
      file.write(s)
    end
  end	
end


