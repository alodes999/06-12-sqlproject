class ShipName
  # Initializes a ShipName object.  Set with one parameter, the unique "id" of each location.
  # 
  # Our class methods are listed at the top, prefaced with self.  They are able to be called without an instantiated object.
  # 
  # We have 1 attribute
  # => @loc_id - an Integer, that will be used to correlate with the same number id in our table.
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
  # Generalized change method for the ship_names Class.
  # 
  # This method accepts 2 arguments, column_to_change, the name of the column we want to modify
  # and value_to_change_to, either a String, or an Integer, depending on which column we edit
  # 
  # This method returns the changed value in the table.
  def change_method(column_to_change, value_to_change_to)
    EIG.execute("UPDATE ship_names SET '#{column_to_change}' = #{value_to_change} WHERE id = #{name_id};")
  end
  # Specific change method for the ship_name column.
  #
  # This method accepts 1 argument, new_ship_name, the String which to change the column value to
  #
  # This returns the changed value in the table
  def change_name(new_ship_name)
    change_method('ship_name', '#{new_ship_name}')
  end
  # Specific change method for the cost column.
  #
  # This method accepts 1 argument, new_ship_cost, the Integer which to change the column value to
  #
  # This returns the changed value in the table  
  def change_cost(new_ship_cost)
    change_method('cost', new_ship_cost)
  end
  # Specific change method for the ship_type_id column.
  #
  # This method accepts 1 argument, new_ship_type, the Integer which to change the column value to
  #
  # This returns the changed value in the table
  def change_type(new_ship_type)
    change_method('ship_types_id', new_ship_type)
  end
  # Specific change method for the ship_location_id column.
  #
  # This method accepts 1 argument, new_ship_location, the Integer which to change the column value to
  #
  # This returns the changed value in the table
  def change_location(new_ship_location)
    change_method('ship_locations_id', new_ship_location)
  end
  
end