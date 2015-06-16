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
# Here I set a variable with ranges to check later in our main while loop
bad_choice = (5..8)
# Our main menu, with options and logic to direct those options
puts "Hello! What would you like to do today?"
ShipLists.main_menu
puts "Please enter a menu option:"
choice = gets.chomp.to_i
# We have the entire menu structure in a while loop, letting it cycle until we get a Quit command with 9
while choice != 9
  # This part of the loop ensures we have a valid option, and will reprompt for a choice.  If 9 is desired, it will reprompt the main
  # menu again.
  while bad_choice.include?(choice) || choice > 9 || choice == 0 
    puts "That is not a valid option, please reenter an option"
    choice = gets.chomp.to_i
  end
  # This case loop will relay the choice from our menu into where we want to go.
  # 1 takes us to our lists
  # 2 takes us to our new entry menu
  # 3 takes us to our edit menu
  # 4 takes us to our delete menu 
  case choice
  # Here is our Lists sub-menu, accessed when the user picks 1 from the main menu
  # 
  # We have 5 options, and a further case loop to execute the options for each list option
  when 1
    ShipLists.option_one
    listchoice = ShipLists.list_five_choice
    # Our case loop for the submenu for lists.
    case listchoice
    when 1
      ShipLists.ship_name_list
    when 2
      ShipLists.ship_type_list
    when 3
      ShipLists.ship_loc_list
    when 4
      puts "What type id should we look up?"
      type_id = gets.chomp.to_i
      
      accept_list = []
      name_valid = ShipType.all
      name_valid.each do |thing|
        accept_list << thing.type_id
      end
      
      while !accept_list.include?(type_id)
        puts "That is not a valid option, please re-enter a type to look up"
        type_id = gets.chomp.to_i
      end
      type_to_look = ShipType.find(type_id)
      list = type_to_look.ships_where_type_matches
      
      list.each do |name|
        puts "#{name.name_id} - #{name.ship_name} - #{name.cost} - #{name.type_id} - #{name.loc_id}"
      end
    when 5
      puts "What location id should we look up?"
      loc_id = gets.chomp.to_i
      
      accept_list = []
      name_valid = ShipLocation.all
      name_valid.each do |thing|
        accept_list << thing.loc_id
      end
      
      while !accept_list.include?(id_to_mod)
        puts "That is not a valid option, please re-enter a ship to modify"
        loc_id = gets.chomp.to_i
      end
      loc_to_look = ShipLocation.find(loc_id)
      list =  loc_to_look.ships_where_stored
      
      list.each do |name|
        puts "#{name.name_id} - #{name.ship_name} - #{name.cost} - #{name.type_id} - #{name.loc_id}"
      end
    when 9
      puts "Ok, back to the top!"
    end
  # Our Entry sub-menu.  Here we define new rows for our tables and insert them  
  when 2
    ShipLists.option_two
    listchoice = ShipLists.list_three_choice
    # Our case list for our Entry sub-menu
    case listchoice
    when 1
      puts "Ok, what ship type would you like to add?"
      type = gets.chomp
      
      new_type = ShipType.add_type(type)
      puts "Alright, type added to the list!"
    when 2
      puts "Ok, what system would you like to add?"
      system = gets.chomp
      puts "And what station?"
      station = gets.chomp
      
      new_loc = ShipLocation.add_location("#{system}, #{station}")
      puts "Alright, added #{system}, #{station} to the list!"
    when 3
      puts "Ok, what's the ship name would you like to add?"
      name = gets.chomp
      puts "And what is the cost of this ship?"
      cost = gets.chomp.to_i
      puts "Ok, what ship type does this ship belong to?  Enter the type id number:"
      typeid = gets.chomp.to_i
      puts "And where is this ship located?  Enter the location id number:"
      locid = gets.chomp.to_i
      
      new_ship = ShipName.add_ship(name, cost, typeid, locid)
      puts "Alright, added #{name} to the list!"
    when 9
      puts "Ok, back to the top!"
    end
  # Here is our Editing sub-menu.  Here we define changes to our list items and send those
  # into our lists
  when 3
    ShipLists.option_three
    listchoice = ShipLists.list_three_choice
    # Here is our Edit Ships sub-menu.  We define the ship changes here.
    # I elected to put the ship changes in a separate sub-menu
    # because there are multiple values that can change.
    case listchoice
    when 1
      puts "Ok, which ship would you like to modify?"
      ShipLists.ship_name_list
      id_to_mod = gets.chomp.to_i
      
      accept_list = []
      name_valid = ShipName.all
      name_valid.each do |thing|
        accept_list << thing.name_id
      end
      
      while !accept_list.include?(id_to_mod)
        puts "That is not a valid option, please re-enter a ship to modify"
        id_to_mod = gets.chomp.to_i
      end
       
      ship_to_mod = ShipName.find(id_to_mod)
      loop_choice = "yes"
      while loop_choice.downcase == "yes"
        ShipLists.option_three_one
        listchoice = ShipLists.list_four_choice
        #Our case logic for this Edit Ships sub-menu
        case listchoice
        when 1
          puts "Ok, what's the new ship name?"
          new_name = gets.chomp
        
          puts "Ok, changing name to #{new_name}!"
          ship_to_mod.ship_name = new_name
        when 2
          puts "Ok, what's the new ship cost?"
          new_cost = gets.chomp.to_i
         
          puts "Ok, changing cost to #{new_cost}!"
          ship_to_mod.cost = new_cost
        when 3
          puts "Ok, what's the id of the new ship type?"
          ShipLists.ship_type_list
          new_type = gets.chomp.to_i
        
          puts "Ok, changing type to #{new_type}!"
          ship_to_mod.type_id = new_type
        when 4
          puts "Ok, what is the new location id?"
          ShipLists.ship_loc_list
          new_loc = gets.chomp.to_i
        
          puts "Ok, changing location to #{new_loc}!" 
          ship_to_mod.loc_id = new_loc
        when 9
          puts "Ok, back to the top!"
        end
      puts "Would you like to make more changes? Please enter yes or no"
      loop_choice = gets.chomp
      end
      ship_to_mod.save
      puts "Ok! Updated the ship on the database!"
    when 2
      type_to_mod = ShipType.new
      puts "Ok, which ship type do you want to modify?"
      ShipLists.ship_type_list
      entry_choice = gets.chomp.to_i
      
      accept_list = []
      name_valid = ShipType.all
      name_valid.each do |thing|
        accept_list << thing.type_id
      end
      
      while !accept_list.include?(entry_choice)
        puts "That is not a valid option, please re-enter a ship to modify"
        entry_choice = gets.chomp.to_i
      end
      type_to_mod.find(entry_choice)
      
      puts "Ok, and what do you want to change the type to?"
      new_type = gets.chomp
      
      puts "Ok, changing the type to #{new_type}!"
      type_to_mod.shiptype = new_type
      type_to_mod.save
    when 3
      loc_to_mod = ShipLocation.new
      puts "Ok, which location do you want to modify?"
      ShipLists.ship_loc_list
      entry_choice = gets.chomp.to_i
      
      accept_list = []
      name_valid = ShipLocations.all
      name_valid.each do |thing|
        accept_list << thing.loc_id
      end
      
      while !accept_list.include?(entry_choice)
        puts "That is not a valid option, please re-enter a location to modify"
        entry_choice = gets.chomp.to_i
      end
      loc_to_mod.find(entry_choice)
      
      puts "And what do you want to change the system to?"
      new_sys = gets.chomp
      puts "And the station?"
      new_stat = gets.chomp
      
      puts "Ok, changing the type to #{new_sys}, #{new_stat}"
      loc_to_mod.system_name = "#{new_sys}, #{new_stat}"
      loc_to_mod.save
    when 9
      puts "Ok, back to the top!"
    end
  # Our Delete sub-menu.  We define which items to delete, and verify the user wishes to delete
  # 
  # The type and location options have additional logic preventing deletion
  # in the event there is a type or location currently attached to a ship.
  # In this case, the user is prompted with a message saying there is something
  # attached and to remove that link before deleting the type/location.
  when 4
    ShipLists.option_four
    listchoice = ShipLists.list_three_choice
    
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
      end
    when 2
      puts "Ok, which type would you like to delete? Please enter the id of the ship type:"
      del_choice = gets.chomp.to_i
      type_to_delete = ShipType.find(del_choice)
      puts "Ok, deleting type #{del_choice} from the types table.  Are you sure? Put y or n."
      dbl_check = gets.chomp
      if dbl_check.downcase != "y"
        puts "Ok, back to the top!"
      else
        if type_to_delete.delete_type
          puts "Ok, deletion confirmed! Deleting record #{del_choice}"
        else
          puts "There are ships associated with that type.  Please reassign those ships before deleting that type!"
          puts "Returning to the Main Menu."
        end
      end
    when 3
      puts "Ok, which location would you like to delete? Please enter the id of the ship location:"
      del_choice = gets.chomp.to_i
      loc_to_delete = ShipLocation.find(del_choice)
      puts "Ok, deleting location #{del_choice} from the locations table.  Are you sure? Put y or n."
      dbl_check = gets.chomp
      if dbl_check.downcase != "y"
        puts "Ok, back to the top!"
      else
        if loc_to_delete.delete_location
          puts "Ok, deletion confirmed! Deleting record #{del_choice}"
        else 
          puts "There are ships associated with that location.  Please reassign those ships before deleting that type!"
          puts "Returning to the Main Menu."
        end
      end
    when 9
      puts "Ok, back to the top!"
    end
  when 9
    puts "To the Main Menu"
  end
  puts "-------------------------"
  puts "Main Menu"
  ShipLists.main_menu
  
  puts "What would you like to do next?"
  choice = gets.chomp.to_i
end