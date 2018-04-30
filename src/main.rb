require './FoodDB.rb'
require './Log.rb'

#foodDB = FoodDB.new("FoodDB.txt")


def printAll (db)
   puts "\n"
   db.each_key do |key|
     if (db[key].class == BasicFood)
       puts key + ": " + db[key].toString
     end
  end
  puts "\n"
  db.each_key do |key|
    if (db[key].class == Recipe)
      puts key + ": " + db[key].toString
    end
  end
end

def showAll (db)
  puts "\n"
  db.each_key do |key|
#    puts key
    puts db[key].toString
  end
end

#def saveTofile()

def find (prefix, foodDB)
  foodDB.getDB.each_key do |key|
    if key.start_with? prefix
      puts foodDB.getDB[key].toString
    end
  end
end


def delete(db,name,date)
  if db.has_key? date
    puts "if db has key" 
    db[date].foodList.delete(name)
  end
  db
end


def main
foodDB = FoodDB.new("FoodDB.txt")
logDB = Log.new("DietLog.txt")
  $stdin.each do | line|
    arr = line.split(" ")
    

    if arr[0] == "quit" or line == "\n"
      logDB.toFile("DietLog.txt")
      foodDB.toFile("FoodDB.txt")
      return
    end
		
    if line  == "print all\n"
      printAll(foodDB.getDB)
    end		
    if arr[0] == "print" and arr[1] != "all"
      if foodDB.getDB[arr[1]] == nil
        puts "That food item is not in the DataBase"
      end
      if foodDB.getDB[arr[1]] != nil
	puts foodDB.getDB[arr[1]].toString
      end
    end

    if arr[0] == "find"
      find(arr[1], foodDB)			
    end

    if arr[0] == "new"

      if arr[1] == "food"
        temp =line.split(' ')[1..-1].join(' ')
        newline  = temp.split(' ')[1..-1].join(' ')
        arr = newline.split(",")
	foodDB.getDB[arr[0]] = BasicFood.new(arr[0],arr[1])
      end

      if arr[1] == "recipe"
	temp =line.split(' ')[1..-1].join(' ')
	newline  = temp.split(' ')[1..-1].join(' ')
	arr = newline.split(",")
	r = Recipe.new (arr[0])
        total =0
        arr.shift
        arr.each do |elt|                                    
          if (foodDB.getDB.has_key?(elt))
            r.foods << foodDB.getDB[elt]
            total += foodDB.getDB[elt].calories
          end
        end
        r.setcalories(total)
        foodDB.add(r)
	puts foodDB.getDB[r.name].toString
      end
    end

    if line == "show all\n"
      showAll(logDB.getDB)
    end	

    if arr[0] == "log"
      if arr.length == 2
        if foodDB.getDB[arr[1]] == nil
          puts "That food item is not in the DataBase"
        end
        if foodDB.getDB[arr[1]] != nil
          currtime = Time.now.strftime("%m/%d/%Y %H:%M")
	  currDate = currtime.split(" ")[0]
	  if logDB.getDB[currDate] == nil
	    log = LogItem.new(currDate)
	    log.foodList << arr[1]
            logDB.getDB[currDate] = log
	  else
	    logDB.getDB[currDate].foodList << arr[1]
          end 
        end
      end

      if arr.length == 3
        if foodDB.getDB[arr[1]] == nil
          puts "That food item is not in the DataBase"
        end
        if foodDB.getDB[arr[1]] != nil
     	  currDate = arr[2]
          if logDB.getDB[currDate] == nil
            log = LogItem.new(currDate)
            logDB.getDB[currDate] = log
            logDB.getDB[currDate].add(arr[1])
          else
            logDB.getDB[currDate].add(arr[1])
          end
        end
      end
    end
    if arr[0] == "delete"
      arr.shift
      arr = arr[0].split(",")
      if foodDB.getDB[arr[0]] == nil
        puts "That food item is not in the DataBase"
      else
	date =arr[1]
	name = arr[0]
	name.gsub!(/\W+/, '')
        if logDB.getDB.has_key? date
    	  logDB.getDB[date].foodList.delete(name)
        end  
      end
    end
    
    if arr[0] == "show" and line  != "show all\n"
      if arr.length == 2
        if logDB.getDB[arr[1].chomp] == nil
          puts "That log  item is not in the DataBase"
        else
	  puts logDB.getDB[arr[1].chomp].foodList
        end
      end
      if arr.length == 1
	currtime = Time.now.strftime("%m/%d/%Y %H:%M")
        currDate = currtime.split(" ")[0]
	puts currDate
	if logDB.getDB[currDate] == nil
          puts "That log  item is not in the DataBase"
        else
          puts logDB.getDB[currDate].foodList
        end
      end
    end
    if line == "save\n"
      logDB.toFile("DietLog.txt")
      foodDB.toFile("FoodDB.txt")
    end
    puts "\n"
  end 		
end

main()
