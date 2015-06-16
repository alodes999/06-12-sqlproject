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
  # Finding a ship_location row from the given id.  This will fill out a new ShipLocation class
  # with the attributes pulled from the row values in our table
  # 
  # Accepts 1 argument, the Integer of our ship_locations table id
  # 
  # Returns a new ShipLocation object
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
  # Returns a new ShipLocation Object, and adds the row to our ship_locations table.
  def self.add_location(solsysloc)
    EIM.execute("INSERT INTO ship_locations ('solar_system_name') VALUES ('#{solsysloc}');")
    
    location_id = EIM.last_insert_row_id
    
    ShipLocation.new(location_id, solsysloc)
  end
  # Instance method for deleting a location
  # 
  # Accepts no arguments, relying on the instantiated object's type_id
  # 
  # Calls our ships_where_stored method to verify the location is empty before deletion
  #
  # Returns Boolean
  def delete_location
    if ships_where_stored.empty?
      EIM.execute("DELETE FROM ship_locations WHERE id = #{@loc_id};")
    else
      false
    end
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
  # Syncs our current ShipLocation Object with it's corresponding row in the ship_locations table of our DB
  # 
  # Accepts no arguments, using the instantiated Object's attributes
  # 
  # Returns [], and updates the row in our Database, syncing it with our Object 
  def save
    EIM.execute("UPDATE ship_locations SET solar_system_name = '#{@system_name}' WHERE id = #{@loc_id};")
  end
end