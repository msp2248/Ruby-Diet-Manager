class Log
	
require './FoodDB.rb'
require './LogItem.rb'
private

#initializes a log hashmap from a file with dates mapping to a logItem
def initialize (filename)
  @logDB = getLog(filename)
end



public	
attr_reader :logDB

#helper funtion to parse a csv file and create a hashmap
def getLog(filename)
  db = Hash.new()
  csvfile = File.open(filename, "r")
  csvfile.each_line do |line|
    line.gsub('\n','')
    arr =line.split(",")
    if arr.length== 2
      arr[0].chomp!
      arr[1].chomp!
      if db[arr[0]]== nil 
	logitem = LogItem.new(arr[0])
	db[arr[0]] = logitem
      end
      db[arr[0]].add(arr[1])
    end
  end 
  db
end

#gets the log database
def getDB
  @logDB
end

#saves the hashmap in csv format in a given file
def toFile (filename)
  file = File.open(filename, 'w')
  logDB.each_key do |date|
    s = ""
    s += date
    logDB[date].foodList.each do |food|
      s += "," + food
    end
    s+="\n"
    file.write(s)
  end
  return
end

end 


