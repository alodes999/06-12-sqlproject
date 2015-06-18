class ShipName
  extend DatabaseClassMethods
  
  attr_accessor :id, :ship_name, :cost, :type_id, :loc_id
  # Initializes a ShipName object.  Set with five optional parameters, the unique "id" of each location.
  # 
  # Our class methods are listed at the top, prefaced with self.  They are able to be called without an instantiated object.
  # 
  # We have 1 attribute
  # => arguments, a Hash that contains our information for our attributes
  def initialize(arguments = {})
    @id = arguments["id"]
    @ship_name = arguments["ship_name"]
    @cost = arguments["cost"]
    @type_id = arguments["ship_types_id"]
    @loc_id = arguments["ship_locations_id"]
  end
  # Syncs our current ShipName Object with it's corresponding row in the ship_names table of our DB
  # 
  # Accepts no arguments, using the instantiated Object's attributes
  # 
  # Returns [], and updates the row in our Database, syncing it with our Object 
  def save
    CONNECTION.execute("UPDATE ship_names SET 'ship_name' = '#{@ship_name}', 'cost' = #{@cost}, 'ship_types_id' = #{@type_id}, 'ship_locations_id' = #{@loc_id} WHERE id = #{@id};")
  end
end