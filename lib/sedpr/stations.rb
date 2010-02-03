require 'json'

class Stations
  
  STATIONS_AS_JSON_FILE = File.join(File.dirname(__FILE__), 'stations.json')
  
  def self.exists?(station_name)
    @stations ||= from_json(File.read(STATIONS_AS_JSON_FILE))
    @stations.exists?(station_name)
  end
  
  def self.from_json(stations_as_json)
    stations = JSON.parse(stations_as_json).collect do |code_and_name|
      code_and_name.to_a.flatten.last
    end
    new(*stations)
  end
  
  def initialize(*stations)
    @stations = stations.collect { |station| station.downcase }
  end
  
  def exists?(station_name)
    (@stations & [station_name.downcase]).first
  end
  
end