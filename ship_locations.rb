class ShipLocation
  attr_accessor :loc_id, :system_name
  # Initializes a ShipLocation object.  Set with one parameter, the unique "id" of each location.
  # 
  # Our class methods are listed at the top, prefaced with self.  They are able to be called without an instantiated object.
  # 
  # We have 1 attribute
  # => @loc_id - an Integer, that will be used to correlate with the same number id in our table.
  def initialize(location_id = nil, system_name = nil)
    @loc_id = location_id
    @system_name = system_name
  end
  
  def self.find(loc_id)
    @loc_id = loc_id
    
    found = EIM.execute("SELECT * FROM ship_locations WHERE id = #{@loc_id};").first
    
    temp_name = found['ship_type']
    
    ShipLocation.new(loc_id, temp_name)
  end
  # Displays a hash showing all entries into the ship_locations table.
  #
  # Accepts no arguments
  # 
  # Returns an array of hashes showing all entries in the ship_locations table.
  def self.all
    list = EIM.execute("SELECT * FROM ship_locations;")
    array_list = []
    
    list.each do |loc|
      array_list << ShipLocation.new(loc["id"], loc["solar_system_name"])
    end
    
    array_list
  end
  # Adds a new entry into the ship_locations table
  #
  # Accepts 2 arguments, solsysloc, a String for the system name, and stationname, a String for the station in the given system.
  #
  # Returns [] in our terminal, and adds the row to our ship_locations table.
  def self.add_location(solsysloc)
    EIM.execute("INSERT INTO ship_locations (solar_system_name) VALUES ('#{solsysloc}');")
  end
  # Deletes a given entry in our ship_locations table
  # 
  # Accepts 1 argument, id_to_delete, an Integer value that corresponds to the row id we want to delete
  # 
  # Returns [] in our terminal, and deletes the row from our ship_locations table
  def self.delete_location(id_to_delete)
    EIM.execute("DELETE FROM ship_locations WHERE id = #{id_to_delete};")
  end
  # Lists the ships at the location referenced with this object's instantiation
  # 
  # Accepts no arguments, only passing the defined argument from instantiation to this method
  #
  # Returns a list of ships currently at the location referenced in our @loc_id attribute
  def ships_where_stored
    list = EIM.execute("SELECT * FROM ship_names WHERE ship_locations_id = #{@loc_id};")
    array_list = []
    
    list.each do |type|
      array_list << ShipName.new(type['id'], type['ship_name'], type['cost'], type['ship_types_id'], type['ship_locations_id'])
    end
    
    array_list
  end
  # Change method.
  # 
  # Accepts 1 argument, the value_to_change.  This will change the record to the entered value to change.
  # 
  # Returns [], changing the appropriate value for our designated location id
  def change_location(value_to_change)
    EIM.execute("UPDATE ship_locations SET solar_system_name = '#{value_to_change}' WHERE id = #{@loc_id};")
  end
end