require 'sqlite3'
require_relative 'ship_names'
require_relative 'ship_types'
require_relative 'ship_locations'
# EIM is my acronym for 'EVE Inventory Management', the appended project name onto my EVE thought process
# for the project
EIM = SQLite3::Database.new('eim.db')

EIM.execute("CREATE TABLE IF NOT EXISTS ship_names (id INTEGER PRIMARY KEY, ship_name TEXT, cost INTEGER, ship_types_id FOREIGN KEY, ship_locations_id FOREIGN KEY);")
EIM.execute("CREATE TABLE IF NOT EXISTS ship_types (id INTEGER PRIMARY KEY, ship_type TEXT);")
EIM.execute("CREATE TABLE IF NOT EXISTS ship_locations (id INTEGER PRIMARY KEY, solar_system_name TEXT, station_name TEXT);")

EIM.results_as_hash = true

# `````````````````````````````````````````````````````````````````````````````````````````````````````


