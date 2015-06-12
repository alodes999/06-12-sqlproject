require 'sqlite3'
require_relative 'ship_names'
require_relative 'ship_types'
require_relative 'ship_locations'
# EIM is my acronym for 'EVE Inventory Management', the appended project name onto my EVE thought process
# for the project
EIM = SQLite3::Database.new('eim.db')

EIM.execute("CREATE TABLE IF NOT EXISTS ship_names (id INTEGER PRIMARY KEY, ship_name TEXT, cost INTEGER, ship_types_id FOREIGN KEY, ship_locations_id FOREIGN KEY);")
EIM.execute("CREATE TABLE IF NOT EXISTS ship_types (id INTEGER PRIMARY KEY, ship_type TEXT);")
EIM.execute("CREATE TABLE IF NOT EXISTS ship_locations (id INTEGER PRIMARY KEY, solar_system_name TEXT, station_name TEXT);")

EIM.results_as_hash = true

# `````````````````````````````````````````````````````````````````````````````````````````````````````

puts "Hello!  What would you like to do today?"
puts "1 - Enter a new ship"
puts "2 - Enter a new ship location"
puts "3 - Enter a new ship type"
puts "4 - Change a ship name"
puts "5 - Change the cost of a ship"
puts "6 - Assign a new system for a ship"
puts "7 - Assign a new station for a ship"
puts "8 - Change a ship type"
puts "9 - Change a system name"
puts "10 - Change a system station name"
puts "15 - Quit"

choice = gets.chomp.to_i
while choice != 15
  while choice > 10 && < 15
    puts "That is an invalid choice, please reenter a choice"
    choice = gets.chomp.to_i
  end
  case choice
  when 1
    
  when 2
    
  when 3
    
  when 4
    
  when 5
    
  when 6
    
  when 7
    
  when 8
    
  when 9
    
  when 10
    
  end
  puts "What would you like to do now?"
  puts "1 - Enter a new ship"
  puts "2 - Enter a new ship location"
  puts "3 - Enter a new ship type"
  puts "4 - Change a ship name"
  puts "5 - Change the cost of a ship"
  puts "6 - Assign a new system for a ship"
  puts "7 - Assign a new station for a ship"
  puts "9 - Quit"
  choice = gets.chomp.to_i
end
    
    