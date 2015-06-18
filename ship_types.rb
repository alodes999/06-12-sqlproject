class ShipType
  extend DatabaseClassMethods
  
  attr_accessor :id, :shiptype
  # Initializes a ShipType object.  Set with one parameter, the unique "id" of each location.
  # 
  # Our class methods are listed at the top, prefaced with self.  They are able to be called without an instantiated object.
  # 
  # We have 1 attribute
  # => @loc_id - an Integer, that will be used to correlate with the same number id in our table.
  def initialize(arguments = {})
    @id = arguments["id"]
    @ship_type = arguments["ship_type"]
  end
  # Finding a ship_type row from the given id.  This will fill out a new ShipType class
  # with the attributes pulled from the row values in our table
  # 
  # Accepts 1 argument, the Integer of our ship_types table id
  # 
  # Returns a new ShipType object
  def self.find_from_table(id)
    @id = id
    
    found = self.find(id)
    
    temp_name = found['ship_type']
    
    ShipType.new(id, temp_name)
  end
  # Adds a new entry into the ship_types table
  #
  # Accepts 1 argument, a String for the ship_type
  #
  # Returns a new ShipType Object, and adds the row to our ship_types table.
  def self.add_type(shiptype)
    CONNECTION.execute("INSERT INTO ship_types (ship_type) VALUES ('#{shiptype}');")
    
    ship_id = CONNECTION.last_insert_row_id
    
    ShipType.new(ship_id, shiptype)
  end
  # Deletes a ship type from our ship_type table.
  # 
  # Accepts no arguments, using an already instantiated ShipType object to get the id to delete
  # 
  # Returns Boolean
  def delete_type
    if ships_where_type_matches.empty?
      CONNECTION.execute("DELETE FROM ship_types WHERE id = #{@id};")
    else
      false
    end
  end
  # Lists the ships of the type referenced with this object's instantiation
  # 
  # Accepts no arguments, only passing the defined argument from instantiation to this method
  #
  # Returns an Array of ship Objects that are the ship_type referenced in our @id attribute
  def ships_where_type_matches
    list = CONNECTION.execute("SELECT * FROM ship_names WHERE ship_types_id = #{@id};")
    array_list = []
    
    list.each do |type|
      array_list << ShipName.new(type['id'], type['ship_name'], type['cost'], type['ship_types_id'], type['ship_locations_id'])
    end
    
    array_list
  end
  # Update method for ship_type database.
  # 
  # Accepts no arguments.  This will sync the ship_type in the database for the referenced id.
  # 
  # Returns [], changing the ship_type for our designated location id
  def save
    CONNECTION.execute("UPDATE ship_types SET ship_type = '#{shiptype}' WHERE id = #{@id};")
  end
end