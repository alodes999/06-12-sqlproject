class ShipLocation
  # Initializes a ShipLocation object.  Set with one parameter, the unique "id" of each location.
  # 
  # Our class methods are listed at the top, prefaced with self.  They are able to be called without an instantiated object.
  # 
  # We have 1 attribute
  # => @loc_id - an Integer, that will be used to correlate with the same number id in our table.
  def initialize(location_id)
    @loc_id = location_id
  end
  
  def self.all
    EIG.execute("SELECT * FROM ship_locations;")
  end
  
  def self.add_location(solsysloc, stationname)
    EIG.execute("INSERT INTO ship_locations (solar_system_name) VALUES ('#{solsysloc}', '#{stationname}');")
  end
  
  def 
  
end