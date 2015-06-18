require 'active_support'
require 'active_support/inflector'

module DatabaseClassMethods

  def all
    table_name = self.to_s.tableize
    results = CONNECTION.execute("SELECT * FROM #{table_name};")
    array_list = []

    list.each do |hash|
      array_list << self.new(hash)
    end

    array_list
  end
  
  def find(id)
    CONNECTION.execute("SELECT * FROM ship_names WHERE id = #{id};").first
  end
  
  def delete(id_to_delete)
    table_name = self.to_s.tableize
    
    CONNECTION.execute("DELETE FROM #{table_name} WHERE id = #{id_to_delete};")
  end
end