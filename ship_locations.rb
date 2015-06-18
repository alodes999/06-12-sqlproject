class ShipLocation
  extend DatabaseClassMethods
  
  attr_accessor :id, :system_name
  # Initializes a ShipLocation object.  Set with one parameter, the unique "id" of each location.
  # 
  # Our class methods are listed at the top, prefaced with self.  They are able to be called without an instantiated object.
  # 
  # We have 1 attribute
  # => @id - an Integer, that will be used to correlate with the same number id in our table.
  def initialize(arguments = {})
    @id = arguments["id"]
    @system_name = arguments["solar_system_name"]
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
      CONNECTION.execute("DELETE FROM ship_locations WHERE id = #{@id};")
    else
      false
    end
  end
  # Lists the ships at the location referenced with this object's instantiation
  # 
  # Accepts no arguments, only passing the defined argument from instantiation to this method
  #
  # Returns a list of ships currently at the location referenced in our @id attribute
  def ships_where_stored
    list = CONNECTION.execute("SELECT * FROM ship_names WHERE ship_locations_id = #{@id};")
    array_list = []
    
    list.each do |type|
      array_list << ShipName.new(type)
    end
    
    array_list
  end
  # Syncs our current ShipLocation Object with it's corresponding row in the ship_locations table of our DB
  # 
  # Accepts no arguments, using the instantiated Object's attributes
  # 
  # Returns [], and updates the row in our Database, syncing it with our Object 
  def save
    CONNECTION.execute("UPDATE ship_locations SET solar_system_name = '#{@system_name}' WHERE id = #{@id};")
  end
end