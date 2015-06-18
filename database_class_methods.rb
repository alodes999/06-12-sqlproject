require 'active_support'
require 'active_support/inflector'

module DatabaseClassMethods

  def all
    table_name = self.to_s.tableize
    results = CONNECTION.execute("SELECT * FROM #{table_name};")
    array_list = []

    results.each do |hash|
      array_list << self.new(hash)
    end

    array_list
  end
  
  def find(id)
    result = CONNECTION.execute("SELECT * FROM ship_names WHERE id = #{id};").first
    
    self.new(result)
  end
  
  def add(arguments={})
    table_name = self.to_s.tableize
    columns_array = arguments.keys
    values_array = arguments.values  
    columns_for_sql = columns_array.join(", ")
    ind_values_for_sql = []
    
    values_array.each do |item|
      if item.is_a?(String)
        ind_values_for_sql << "'#{item}'"
      else
        ind_values_for_sql << item
      end
    end
    
    values_for_sql = ind_values_for_sql.join(", ")
    CONNECTION.execute("INSERT INTO #{table_name} (#{columns_for_sql}) VALUES (#{values_for_sql});")
    arguments["id"] = CONNECTION.last_insert_row_id
    self.new(arguments)
  end
  
  def delete(id_to_delete)
    table_name = self.to_s.tableize
    
    CONNECTION.execute("DELETE FROM #{table_name} WHERE id = #{id_to_delete};")
  end
end