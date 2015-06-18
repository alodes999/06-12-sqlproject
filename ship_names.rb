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
  # Finding a ship row from the given id.  This will fill out a new ShipName class
  # with the attributes pulled from the row values in our table
  # 
  # Accepts 1 argument, the Integer of our ship_names table id
  # 
  # Returns a new ShipName object
  def self.find_from_table(id)
    @id = id
  
    found = self.find(id)
  
    ShipName.new(found)
  end
  # Adds a new entry into the ship_names table
  #
  # Accepts 1 argument, a String for the ship_name
  #
  # Returns a new ShipName Object, and adds the row to our ship_names table.
  def self.add_ship(shipname, shipcost, type_id, loc_id)
    CONNECTION.execute("INSERT INTO ship_names (ship_name, cost, ship_types_id, ship_locations_id) VALUES ('#{shipname}', #{shipcost}, #{type_id}, #{loc_id});")
    
    new_id = CONNECTION.last_insert_row_id
    
    ShipName.new(new_id, shipname, shipcost, type_id, loc_id)
  end
  # Deletes a given entry in our ship_names table
  # 
  # Accepts 1 argument, id_to_delete, an Integer value that corresponds to the row id we want to delete
  # 
  # Returns [] in our terminal, and deletes the row from our ship_names table
  def self.delete_ship(id_to_delete)
    CONNECTION.execute("DELETE FROM ship_names WHERE id = #{id_to_delete};")
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