class ShipType
  extend DatabaseClassMethods
  
  attr_accessor :id, :ship_type
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
      array_list << ShipName.new(type)
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