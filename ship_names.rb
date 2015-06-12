class ShipName
  
  def initialize(name_id)
    @name_id = name_id
  end
  # Displays a hash showing all entries into the ship_names table.
  #
  # Accepts no arguments
  # 
  # Returns an array of hashes showing all entries in the ship_names table.
  def self.all
    EIG.execute("SELECT * FROM ship_names;")
  end
  # Adds a new entry into the ship_names table
  #
  # Accepts 1 argument, a String for the ship_name
  #
  # Returns [] in our terminal, and adds the row to our ship_names table.
  def self.add_ship(shipname, shipcost, type_id, loc_id)
    EIG.execute("INSERT INTO ship_names (ship_name, cost, ship_types_id, ship_locations_id) VALUES ('#{shipname}', #{shipcost}, #{type_id}, #{loc_id});")
  end
  # Deletes a given entry in our ship_names table
  # 
  # Accepts 1 argument, id_to_delete, an Integer value that corresponds to the row id we want to delete
  # 
  # Returns [] in our terminal, and deletes the row from our ship_names table
  def self.delete_ship(id_to_delete)
    EIG.execute("DELETE FROM ship_names WHERE id = #{id_to_delete};")
  end
  # Shows the row corresponding to the instantiated id of the object.
  #
  # Accepts no arguments
  # 
  # Returns the hash of the row the instantiated id refers to
  def show_info
    EIG.execute("SELECT * FROM ship_names WHERE id = @{name_id};")
  end
  
  def change_method(column_to_change, value_to_change_to)
    EIG.execute("UPDATE ship_names SET '#{column_to_change}' = #{value_to_change} WHERE id = #{name_id};")
  end
  
  def change_name(new_ship_name)
    change_method('name', '#{new_ship_name}')
  end
  
  def change_cost(new_ship_cost)
    change_method('cost', new_ship_cost)
  end
  
  def change_type(new_ship_type)
    change_method('ship_types_id', new_ship_type)
  end
  
  def change_location(new_ship_location)
    change_method('ship_locations_id', new_ship_location)
  end
  
end