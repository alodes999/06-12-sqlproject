class ShipLocation
  # Initializes a ShipLocation object.  Set with one parameter, the unique "id" of each location.
  # 
  # Our class methods are listed at the top, prefaced with self.  They are able to be called without an instantiated object.
  # 
  # We have 1 attribute
  # => @loc_id - an Integer, that will be used to correlate with the same number id in our table.
  def initialize(location_id)
    @loc_id = location_id
  end
  # Displays a hash showing all entries into the ship_locations table.
  #
  # Accepts no arguments
  # 
  # Returns an array of hashes showing all entries in the ship_locations table.
  def self.all
    EIG.execute("SELECT * FROM ship_locations;")
  end
  # Adds a new entry into the ship_locations table
  #
  # Accepts 2 arguments, solsysloc, a String for the system name, and stationname, a String for the station in the given system.
  #
  # Returns [] in our terminal, and adds the row to our ship_locations table.
  def self.add_location(solsysloc, stationname)
    EIG.execute("INSERT INTO ship_locations (solar_system_name) VALUES ('#{solsysloc}', '#{stationname}');")
  end
  # Deletes a given entry in our ship_locations table
  # 
  # Accepts 1 argument, id_to_delete, an Integer value that corresponds to the row id we want to delete
  # 
  # Returns [] in our terminal, and deletes the row from our ship_locations table
  def self.delete_location(id_to_delete)
    EIG.execute("DELETE FROM ship_locations WHERE id = #{id_to_delete};")
  end
  # Lists the ships at the location referenced with this object's instantiation
  # 
  # Accepts no arguments, only passing the defined argument from instantiation to this method
  #
  # Returns a list of ships currently at the location referenced in our @loc_id attribute
  def ships
    EIG.execute("SELECT * FROM ship_names WHERE ship_locations_id = #{@loc_id};")
  end
  # Changes the name of the currently selected (the instantiated object's referenced) system location name
  #
  # Accepts 1 argument, a String containing the new system name.  Calls our change_general method to accomplish the change
  # 
  # Returns [] in our terminal, changing the solar_system_name for the designated location id
  def change_system(new_sys_name)
    change_general('solar_system_name', new_sys_name)
  end
  # Changes the name of the currently selected (the instantiated object's referenced) system station name
  #
  # Accepts 1 argument, a String containing the new station name.  Calls our change_general method to accomplish the change
  # 
  # Returns [] in our terminal, changing the station_name for the designated location id
  def change_station(new_stat_name)
    change_general('station_name', new_stat_name)
  end
  # Refactored change methods.
  # 
  # Accepts 2 arguments, the column_to_change, and the value_to_change.  The calling method for this will pick
  # the correct column_to_change, and the value to change.
  # 
  # Returns [], changing the appropriate value for our designated location id
  def change_general(column_to_change, value_to_change)
    EIG.execute("UPDATE ship_locations SET '#{column_to_change}' = '#{value_to_change}' WHERE id = #{@loc_id};")
  end
end