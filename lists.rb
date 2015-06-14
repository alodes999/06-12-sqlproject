module ShipLists

  def self.main_menu
    puts "1 - Look at a list"
    puts "2 - Enter a new record"
    puts "3 - Change a record"
    puts "4 - Delete a record"
    puts "9 - Quit"
  end

  def self.option_one
    puts "1 - Look at ships list"
    puts "2 - Look at ship types list"
    puts "3 - Look at ship locations list"
    puts "9 - Go back"
  end

  def self.option_two
    puts "1 - Enter a new ship type"
    puts "2 - Enter a new ship location"
    puts "3 - Enter a new ship"
    puts "9 - Go back"
  end

  def self.option_three
    puts "1 - Change a ship record"
    puts "2 - Change a location record"
    puts "3 - Change a ship type record"
    puts "9 - Go back"
  end

  def self.option_three_one
    puts "1 - Change a ship name"
    puts "2 - Change a ship cost"
    puts "3 - Change a ship type"
    puts "4 - Change a ship location"
    puts "9 - Go back"
  end

  def self.option_four
    puts "1 - Delete a ship record"
    puts "2 - Delete a ship type"
    puts "3 - Delete a ship location"
    puts "9 - Go back"
  end
  
  def self.list_choice
    listchoice = gets.chomp.to_i
    while listchoice != 1..3 || choice != 9
      puts "That is not a valid option, please reenter an option"
      listchoice = gets.chomp.to_i
    end
  end
  
  def self.list_choice_three_one
    listchoice = gets.chomp.to_i
    while listchoice != 1..4 || choice != 9
      puts "That is not a valid option, please reenter an option"
      listchoice = gets.chomp.to_i
    end
  end
end