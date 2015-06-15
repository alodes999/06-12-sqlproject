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
# Here I set 3 different variables with ranges to check later in our while loops
#
# These are here because I tried to have an actual Lists Module, but I couldn't
# get the logic working between the module and if/else statements, so I went
# less DRY and just put the actual menus and logic here in app, instead of a
# separate Lists Module.
bad_choice_threelist = (4..8)
bad_choice_fourlist = (5..8)
bad_choice_fivelist = (6..8)
# Our main menu, with options and logic to direct those options
puts "Hello! What would you like to do today?"
puts "1 - Look at a list"
puts "2 - Enter a new record"
puts "3 - Change a record"
puts "4 - Delete a record"
puts "9 - Quit"
puts "Please enter a menu option:"
choice = gets.chomp.to_i
# We have the entire menu structure in a while loop, letting it cycle until we get a Quit command with 9
while choice != 9
  # This part of the loop ensures we have a valid option, and will reprompt for a choice.  If 9 is desired, it will reprompt the main
  # menu again.
  while bad_choice_fourlist.include?(choice) || choice > 9 || choice == 0 
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
    puts "Which list would you like to look at?"
    puts "1 - Look at ships list"
    puts "2 - Look at ship types list"
    puts "3 - Look at ship locations list"
    puts "4 - Look at all ships in a given type"
    puts "5 - Look at all ships in a given location"
    puts "9 - Go back"
    # This is our logic to get a valid choice again
    listchoice = gets.chomp.to_i
    while bad_choice_fivelist.include?(listchoice) || listchoice > 9 || listchoice == 0
      puts "That is not a valid option, please reenter an option"
      listchoice = gets.chomp.to_i
    end
    # Our case loop for the submenu for lists.
    case listchoice
    when 1
      puts ShipName.all
    when 2
      puts ShipType.all
    when 3
      puts ShipLocation.all
    when 4
      puts "What type id should we look up?"
      type_id = gets.chomp.to_i
      type_to_look = ShipType.new(type_id)
      puts type_to_look.ships_where_type_matches
    when 5
      puts "What location id should we look up?"
      loc_id = gets.chomp.to_i
      loc_to_look = ShipLocation.new(loc_id)
      puts loc_to_look.ships_where_stored
    when 9
      puts "Ok, back to the top!"
    end
  # Our Entry sub-menu.  Here we define new rows for our tables and insert them  
  when 2
    puts "What entry would you like to make?"
    puts "1 - Enter a new ship type"
    puts "2 - Enter a new ship location"
    puts "3 - Enter a new ship"
    puts "9 - Go back"
    # Our valid choice logic
    listchoice = gets.chomp.to_i
    while bad_choice_threelist.include?(listchoice) || listchoice > 9 || listchoice == 0
      puts "That is not a valid option, please reenter an option"
      listchoice = gets.chomp.to_i
    end
    # Our case list for our Entry sub-menu
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
  # Here is our Editing sub-menu.  Here we define changes to our list items and send those
  # into our lists
  when 3
    puts "What would you like to change?"
    puts "1 - Change a ship record"
    puts "2 - Change a ship type record"
    puts "3 - Change a location record"
    puts "9 - Go back"
    # Again, our choice logic
    listchoice = gets.chomp.to_i
    while bad_choice_threelist.include?(listchoice) || listchoice > 9 || listchoice == 0
      puts "That is not a valid option, please reenter an option"
      listchoice = gets.chomp.to_i
    end
    # Here is our Edit Ships sub-menu.  We define the ship changes here.
    # I elected to put the ship changes in a separate sub-menu
    # because there are multiple values that can change.
    case listchoice
    when 1
      puts "Ok, how would you like to modify a ship entry?"
      puts "1 - Change a ship name"
      puts "2 - Change a ship cost"
      puts "3 - Change a ship type"
      puts "4 - Change a ship location"
      puts "9 - Go back"
      # More choice logic
      listchoice = gets.chomp.to_i
      while bad_choice_fourlist.include?(listchoice) || listchoice > 9 || listchoice == 0      
        puts "That is not a valid option, please reenter an option"
        listchoice = gets.chomp.to_i
      end
      #Our case logic for this Edit Ships sub-menu
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
        puts "What's the id of the new ship type?"
        new_type = gets.chomp.to_i
        
        puts "Ok, changing type to #{new_type}"
        ship_to_change = ShipName.new(id_to_change)
        ship_to_change.change_type(new_type)
        puts "Alright!  Type changed!"
      when 4
        puts "What's the id of the ship you want to change?"
        id_to_change = gets.chomp.to_i
        puts "What is the new location id?"
        new_loc = gets.chomp.to_i
        
        puts "Ok, changing location to #{new_loc}" 
        ship_to_change = ShipName.new(id_to_change)
        ship_to_change.change_location(new_loc)
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
  # Our Delete sub-menu.  We define which items to delete, and verify the user wishes to delete
  # 
  # The type and location options have additional logic preventing deletion
  # in the event there is a type or location currently attached to a ship.
  # In this case, the user is prompted with a message saying there is something
  # attached and to remove that link before deleting the type/location.
  when 4
    puts "What would you like to delete?"
    puts "1 - Delete a ship record"
    puts "2 - Delete a ship type"
    puts "3 - Delete a ship location"
    puts "9 - Go back"
    # More tasty choice logic
    listchoice = gets.chomp.to_i
    while bad_choice_threelist.include?(listchoice) || listchoice > 9 || listchoice == 0
      puts "That is not a valid option, please reenter an option"
      listchoice = gets.chomp.to_i
    end
    # Our case loop for the Delete sub-menu
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
      del_type = ShipType.new(del_choice)
      if del_type.ships_where_type_matches.length > 0
        puts "There are ships associated with that type.  Please reassign those ships before deleting that type!"
        puts "Returning to the Main Menu."
      else
        puts "Ok, deleting ship #{del_choice} from the types table.  Are you sure? Put y or n."
        dbl_check = gets.chomp
        if dbl_check.downcase != "y"
          puts "Ok, back to the top!"
        else
          puts "Ok, deletion confirmed! Deleting record #{del_choice}"
          ShipType.delete_type(del_choice)
          puts "Ok, deleted record #{del_choice} from the list."
        end
      end
    when 3
      puts "Ok, which location would you like to delete? Please enter the id of the ship location:"
      del_choice = gets.chomp.to_i
      del_ship = ShipLocation.new(del_choice)
      if del_ship.ships_where_stored.length > 0
        puts "There are ships associated with that location.  Please reassign those ships before deleting that type!"
        puts "Returning to the Main Menu"
      else
        puts "Ok, deleting ship #{del_choice} from the locations table.  Are you sure? Put y or n."
        dbl_check = gets.chomp
        if dbl_check.downcase != "y"
          puts "Ok, back to the top!"
        else
          puts "Ok, deletion confirmed! Deleting record #{del_choice}"
          ShipLocation.delete_location(del_choice)
          puts "Ok, deleted record #{del_choice} from the list."
        end
      end
    when 9
      puts "Ok, back to the top!"
    end
  when 9
    puts "To the Main Menu"
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