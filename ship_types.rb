class ShipType
  
  def initialize(type_id)
    @type_id = type_id
  end
  # Displays a hash showing all entries into the ship_types table.
  #
  # Accepts no arguments
  # 
  # Returns an array of hashes showing all entries in the ship_types table.
  def self.all
    EIG.execute("SELECT * FROM ship_types;")
  end
  # Adds a new entry into the ship_locations table
  #
  # Accepts 1 argument, a String for the ship_type
  #
  # Returns [] in our terminal, and adds the row to our ship_types table.
  def self.add_type(shiptype)
    EIG.execute("INSERT INTO ship_types (ship_type) VALUES ('#{shiptype}');")
  end
  # Deletes a given entry in our ship_types table
  # 
  # Accepts 1 argument, id_to_delete, an Integer value that corresponds to the row id we want to delete
  # 
  # Returns [] in our terminal, and deletes the row from our ship_types table
  def self.delete_type(id_to_delete)
    EIG.execute("DELETE FROM ship_types WHERE id = #{id_to_delete};")
  end
  # Lists the ships of the type referenced with this object's instantiation
  # 
  # Accepts no arguments, only passing the defined argument from instantiation to this method
  #
  # Returns a list of ships that are the ship_type referenced in our @loc_id attribute
  def ships_where_type_matches
    EIG.execute("SELECT * FROM ship_names WHERE ship_types = #{@type_id};")
  end
  # Change method for ship_type.
  # 
  # Accepts 1 arguments, type_change.  This will change the ship_type for the referenced type_id
  # 
  # Returns [], changing the appropriate value for our designated location id
  def change_type(type_change)
    EIG.execute("UPDATE ship_types SET ship_type = '#{type_change}' WHERE id = #{@type_id};")
  end
end