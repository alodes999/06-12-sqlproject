class ShipName
  attr_accessor :name_id, :ship_name, :cost, :type_id, :loc_id
  # Initializes a ShipName object.  Set with five optional parameters, the unique "id" of each location.
  # 
  # Our class methods are listed at the top, prefaced with self.  They are able to be called without an instantiated object.
  # 
  # We have 1 attribute
  # => @loc_id - an Integer, that will be used to correlate with the same number id in our table.
  def initialize(name_id = nil, ship_name = nil, cost = nil, type_id = nil, loc_id = nil)
    @name_id = name_id
    @ship_name = ship_name
    @cost = cost
    @type_id = type_id
    @loc_id = loc_id
  end
  
  def self.find(name_id)
    @name_id = name_id
  
    found = EIM.execute("SELECT * FROM ship_names WHERE id = #{@name_id};").first
  
    temp_name = found['ship_name']
    temp_cost = found['cost']
    temp_type = found['ship_types_id']
    temp_loc = found['ship_locations_id']
  
    ShipName.new(name_id, temp_name, temp_cost, temp_type, temp_loc)
  end
  # Displays a hash showing all entries into the ship_names table.
  #
  # Accepts no arguments
  # 
  # Returns an array of hashes showing all entries in the ship_names table.
  def self.all
    list = EIM.execute("SELECT * FROM ship_names;")
    array_list = []
    
    list.each do |name|
      array_list << ShipName.new(name["id"], name["ship_name"], name["cost"], name["ship_types_id"], name["ship_locations_id"])
    end
    
    array_list
  end
  # Adds a new entry into the ship_names table
  #
  # Accepts 1 argument, a String for the ship_name
  #
  # Returns [] in our terminal, and adds the row to our ship_names table.
  def self.add_ship(shipname, shipcost, type_id, loc_id)
    EIM.execute("INSERT INTO ship_names (ship_name, cost, ship_types_id, ship_locations_id) VALUES ('#{shipname}', #{shipcost}, #{type_id}, #{loc_id});")
  end
  # Deletes a given entry in our ship_names table
  # 
  # Accepts 1 argument, id_to_delete, an Integer value that corresponds to the row id we want to delete
  # 
  # Returns [] in our terminal, and deletes the row from our ship_names table
  def self.delete_ship(id_to_delete)
    EIM.execute("DELETE FROM ship_names WHERE id = #{id_to_delete};")
  end
  # Shows the row corresponding to the instantiated id of the object.
  #
  # Accepts no arguments
  # 
  # Returns the hash of the row the instantiated id refers to
  def show_info
    EIM.execute("SELECT * FROM ship_names WHERE id = @{name_id};")
  end
  
  def update_to_database
    EIM.execute("UPDATE ship_names SET 'ship_name' = '#{@ship_name}', 'cost' = #{@cost}, 'ship_types_id' = #{@type_id}, 'ship_locations_id' = #{@loc_id} WHERE id = #{@name_id};")
  end
end