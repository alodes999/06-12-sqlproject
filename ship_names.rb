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
end