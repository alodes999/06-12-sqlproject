require 'active_support'
require 'active_support/inflector'

module DatabaseInstanceMethods
  # Returns the stored value in the field passed from our DB.  The id number the method looks
  # for is referenced in the Object that the method is called on.
  # 
  # Accepts 1 argument, the field in our table we want to retrieve the information from
  # 
  # Returns a String or Integer, or whatever value is stored in the field we are requesting
  def get(field)
    table_name = self.class.to_s.tableize
    
    CONNECTION.execute("SELECT * FROM #{table_name} WHERE id = #{@id}}").first
    result[field]
  end
  
  def save
    
  end
end