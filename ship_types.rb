class ShipType
  attr_accessor :type_id, :shiptype
  # Initializes a ShipType object.  Set with one parameter, the unique "id" of each location.
  # 
  # Our class methods are listed at the top, prefaced with self.  They are able to be called without an instantiated object.
  # 
  # We have 1 attribute
  # => @loc_id - an Integer, that will be used to correlate with the same number id in our table.
  def initialize(type_id = nil, shiptype = nil)
    @type_id = type_id
    @shiptype = shiptype
  end
  
  def self.find(type_id)
    @type_id = type_id
    
    found = EIM.execute("SELECT * FROM ship_types WHERE id = #{@type_id};").first
    
    temp_name = found['ship_type']
    
    ShipType.new(type_id, temp_name)
  end
  # Displays a hash showing all entries into the ship_types table.
  #
  # Accepts no arguments
  # 
  # Returns an array of hashes showing all entries in the ship_types table.
  def self.all
    list = EIM.execute("SELECT * FROM ship_types;")
    array_list = []
    
    list.each do |type|
      array_list << ShipType.new(type["id"], type["ship_type"])
    end
    array_list
  end
  # Adds a new entry into the ship_types table
  #
  # Accepts 1 argument, a String for the ship_type
  #
  # Returns [] in our terminal, and adds the row to our ship_types table.
  def self.add_type(shiptype)
    EIM.execute("INSERT INTO ship_types (ship_type) VALUES ('#{shiptype}');")
  end
  # Deletes a given entry in our ship_types table
  # 
  # Accepts 1 argument, id_to_delete, an Integer value that corresponds to the row id we want to delete
  # 
  # Returns [] in our terminal, and deletes the row from our ship_types table
  def self.delete_type(id_to_delete)
    EIM.execute("DELETE FROM ship_types WHERE id = #{id_to_delete};")
  end
  # Lists the ships of the type referenced with this object's instantiation
  # 
  # Accepts no arguments, only passing the defined argument from instantiation to this method
  #
  # Returns a list of ships that are the ship_type referenced in our @loc_id attribute
  def ships_where_type_matches
    list = EIM.execute("SELECT * FROM ship_names WHERE ship_types_id = #{@type_id};")
    array_list = []
    
    list.each do |type|
      array_list << ShipName.new(type['id'], type['ship_name'], type['cost'], type['ship_types_id'], type['ship_locations_id'])
    end
    
    array_list
  end
  # Change method for ship_type.
  # 
  # Accepts 1 arguments, type_change.  This will change the ship_type for the referenced type_id
  # 
  # Returns [], changing the ship_type for our designated location id
  def save
    EIM.execute("UPDATE ship_types SET ship_type = '#{shiptype}' WHERE id = #{@type_id};")
  end
end