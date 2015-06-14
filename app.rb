require 'sqlite3'
require_relative 'ship_names'
require_relative 'ship_types'
require_relative 'ship_locations'
require_relative 'lists'
# EIM is my acronym for 'EVE Inventory Management', the appended project name onto my EVE thought process
# for the project
EIM = SQLite3::Database.new('eim.db')

EIM.execute("CREATE TABLE IF NOT EXISTS ship_names (id INTEGER PRIMARY KEY, ship_name TEXT, cost INTEGER, ship_types_id INTEGER, ship_locations_id INTEGER, FOREIGN KEY(ship_types_id) REFERENCES ship_types(id) , FOREIGN KEY(ship_locations_id) REFERENCES ship_locations(id));")
EIM.execute("CREATE TABLE IF NOT EXISTS ship_types (id INTEGER PRIMARY KEY, ship_type TEXT);")
EIM.execute("CREATE TABLE IF NOT EXISTS ship_locations (id INTEGER PRIMARY KEY, solar_system_name TEXT);")

EIM.results_as_hash = true

# `````````````````````````````````````````````````````````````````````````````````````````````````````
bad_choice_threelist = (4..8)
bad_choice_fourlist = (5..8)
bad_choice_fivelist = (6..8)

puts "Hello! What would you like to do today?"
puts "1 - Look at a list"
puts "2 - Enter a new record"
puts "3 - Change a record"
puts "4 - Delete a record"
puts "9 - Quit"
puts "Please enter a menu option:"
choice = gets.chomp.to_i
while choice != 9
  while bad_choice_fourlist.include?(choice) || choice > 9 || choice == 0 
    puts "That is not a valid option, please reenter an option"
    choice = gets.chomp.to_i
  end

  case choice
  when 1
    puts "Which list would you like to look at?"
    puts "1 - Look at ships list"
    puts "2 - Look at ship types list"
    puts "3 - Look at ship locations list"
    puts "9 - Go back"
    
    listchoice = gets.chomp.to_i
    while bad_choice_threelist.include?(listchoice) || listchoice > 9 || listchoice == 0
      puts "That is not a valid option, please reenter an option"
      listchoice = gets.chomp.to_i
    end
    
    case listchoice
    when 1
      puts ShipName.all
    when 2
      puts ShipType.all
    when 3
      puts ShipLocation.all
    when 9
      puts "Ok, back to the top!"
    end
    
  when 2
    puts "What entry would you like to make?"
    puts "1 - Enter a new ship type"
    puts "2 - Enter a new ship location"
    puts "3 - Enter a new ship"
    puts "9 - Go back"
    
    listchoice = gets.chomp.to_i
    while bad_choice_threelist.include?(listchoice) || listchoice > 9 || listchoice == 0
      puts "That is not a valid option, please reenter an option"
      listchoice = gets.chomp.to_i
    end
    
    case listchoice
    when 1
      puts "Ok, what ship type would you like to add?"
      type = gets.chomp
      
      puts "Ok, adding #{type}!"
      ShipType.add_type(type)
      puts "Alright, type added to the list!"
    when 2
      puts "Ok, what system would you like to add?"
      system = gets.chomp
      puts "And what station?"
      station = gets.chomp
      
      puts "Ok, adding #{system}, #{station} to the list!"
      ShipLocation.add_location("#{system}, #{station}")
      puts "Alright, location added to the list!"
    when 3
      puts "Ok, what's the ship name would you like to add?"
      name = gets.chomp
      puts "And what is the cost of this ship?"
      cost = gets.chomp.to_i
      puts "Ok, what ship type does this ship belong to?  Enter the type id number:"
      typeid = gets.chomp.to_i
      puts "And where is this ship located?  Enter the location id number:"
      locid = gets.chomp.to_i
      
      puts "Ok, adding #{name} to the list!"
      ShipName.add_ship(name, cost, typeid, locid)
      puts "Alright, added #{name} to the list!"
    when 9
      puts "Ok, back to the top!"
    end
  
  when 3
    puts "What would you like to change?"
    puts "1 - Change a ship record"
    puts "2 - Change a location record"
    puts "3 - Change a ship type record"
    puts "9 - Go back"
    
    listchoice = gets.chomp.to_i
    while bad_choice_threelist.include?(listchoice) || listchoice > 9 || listchoice == 0
      puts "That is not a valid option, please reenter an option"
      listchoice = gets.chomp.to_i
    end
    
    case listchoice
    when 1
      puts "Ok, how would you like to modify a ship entry?"
      puts "1 - Change a ship name"
      puts "2 - Change a ship cost"
      puts "3 - Change a ship type"
      puts "4 - Change a ship location"
      puts "9 - Go back"
      
      listchoice = gets.chomp.to_i
      while bad_choice_fourlist?(listchoice) || listchoice > 9 || listchoice == 0      
        puts "That is not a valid option, please reenter an option"
        listchoice = gets.chomp.to_i
      end
      
      case listchoice
      when 1
        puts "What's the id of the ship you want to change?"
        id_to_change = gets.chomp.to_i
        puts "What's the new ship name?"
        new_name = gets.chomp
        
        puts "Ok, changing name to #{new_name}"
        ship_to_change = ShipName.new(id_to_change)
        ship_to_change.change_name(new_name)
        puts "Alright!  Name changed!"
      when 2
        puts "What's the id of the ship you want to change?"
        id_to_change = gets.chomp.to_i
        puts "What's the new ship cost?"
        new_cost = gets.chomp.to_i
        
        puts "Ok, changing cost to #{new_cost}"
        ship_to_change = ShipName.new(id_to_change)
        ship_to_change.change_cost(new_cost)
        puts "Alright!  Cost changed!"
      when 3
        puts "What's the id of the ship you want to change?"
        id_to_change = gets.chomp.to_i
        puts "What's the new ship type?"
        new_type = gets.chomp
        
        puts "Ok, changing type to #{new_type}"
        ship_to_change = ShipName.new(id_to_change)
        ship_to_change.change_type(new_type)
        puts "Alright!  Type changed!"
      when 4
        puts "What's the id of the ship you want to change?"
        id_to_change = gets.chomp.to_i
        puts "Where is the new system?"
        new_sys = gets.chomp
        putes "And the new station?"
        new_stat = gets.chomp
        
        puts "Ok, changing location to #{new_sys} - #{new_stat}"
        ship_to_change = ShipName.new(id_to_change)
        ship_to_change.change_name("#{new_sys} - #{new_stat}")
        puts "Alright!  Location changed!"
      when 9
        puts "Ok, back to the top!"
      end
    when 2
      puts "Ok, what entry do you want to modify?"
      entry_choice = gets.chomp.to_i
      puts "Ok, and what do you want to change the type to?"
      new_type = gets.chomp
      
      puts "Ok, changing the type to #{new_type}!"
      type_to_change = ShipType.new(entry_choice)
      type_to_change.change_type(new_type)
      puts "Ok, that ship type has been changed to #{new_type}!"
    when 3
      puts "Ok, what entry do you want to modify?"
      entry_choice = gets.chomp.to_i
      puts "And what do you want to change the system to?"
      new_sys = gets.chomp
      puts "And the station?"
      new_stat = gets.chomp
      
      puts "Ok, changing the type to #{new_sys}, #{new_stat}"
      loc_to_change = ShipLocation.new(entry_choice)
      loc_to_change.change_location("#{new_sys}, #{new_stat}")
      puts "Ok, that location has been changed to #{new_sys}, #{new_stat}!"
    when 9
      puts "Ok, back to the top!"
    end
  
  when 4
    puts "What would you like to delete?"
    puts "1 - Delete a ship record"
    puts "2 - Delete a ship type"
    puts "3 - Delete a ship location"
    puts "9 - Go back"
    
    listchoice = gets.chomp.to_i
    while bad_choice_threelist.include?(listchoice) || listchoice > 9 || listchoice == 0
      puts "That is not a valid option, please reenter an option"
      listchoice = gets.chomp.to_i
    end
    
    case listchoice
    when 1
      puts "Ok, which ship would you like to delete? Please enter the id of the ship:"
      del_choice = gets.chomp.to_i
      
      puts "Ok, deleting ship #{del_choice} from the ships table.  Are you sure? Put y or n."
      dbl_check = gets.chomp
      if dbl_check.downcase != "y"
        puts "Ok, back to the top!"
      else
        puts "Ok, deletion confirmed! Deleting record #{del_choice}"
        ShipName.delete_ship(del_choice)
        puts "Ok, deleted record #{del_choice} from the list."
      end
    when 2
      puts "Ok, which type would you like to delete? Please enter the id of the ship type:"
      del_choice = gets.chomp.to_i
      
      puts "Ok, deleting ship #{del_choice} from the types table.  Are you sure? Put y or n."
      dbl_check = gets.chomp
      if dbl_check.downcase != "y"
        puts "Ok, back to the top!"
      else
        puts "Ok, deletion confirmed! Deleting record #{del_choice}"
        ShipType.delete_type(del_choice)
        puts "Ok, deleted record #{del_choice} from the list."
      end
    when 3
      puts "Ok, which location would you like to delete? Please enter the id of the ship location:"
      del_choice = gets.chomp.to_i
      
      puts "Ok, deleting ship #{del_choice} from the locations table.  Are you sure? Put y or n."
      dbl_check = gets.chomp
      if dbl_check.downcase != "y"
        puts "Ok, back to the top!"
      else
        puts "Ok, deletion confirmed! Deleting record #{del_choice}"
        ShipLocation.delete_location(del_choice)
        puts "Ok, deleted record #{del_choice} from the list."
      end
    when 9
      puts "Ok, back to the top!"
    end
  end
  puts "Main Menu"
  puts "1 - Look at a list"
  puts "2 - Enter a new record"
  puts "3 - Change a record"
  puts "4 - Delete a record"
  puts "9 - Quit"
  
  puts "What would you like to do next?"
  choice = gets.chomp.to_i
end