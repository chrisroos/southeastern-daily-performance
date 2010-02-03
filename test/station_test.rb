require 'test_helper'
require 'stations'

class StationsTest < Test::Unit::TestCase
  
  def setup
    @stations = Stations.new('Ramsgate', 'London Bridge')
  end
  
  def test_should_not_find_a_station_that_does_not_exist
    assert ! @stations.exists?('Foo')
  end
  
  def test_should_find_a_station
    assert @stations.exists?('Ramsgate')
  end
  
  def test_should_find_a_station_irrespective_of_case
    assert @stations.exists?('London Bridge')
  end
  
end

class StationsFromJsonTest < Test::Unit::TestCase
  
  def setup
    stations_as_json = <<-EndJson
[
{"LBG":"London Bridge"},
{"RAM":"Ramsgate"}
]
    EndJson
    @stations = Stations.from_json(stations_as_json)
  end
  
  def test_should_not_find_a_station_that_does_not_exist
    assert ! @stations.exists?('Foo')
  end
  
  def test_should_find_a_station
    assert @stations.exists?('Ramsgate')
  end
  
  def test_should_find_a_station_irrespective_of_case
    assert @stations.exists?('London Bridge')
  end
  
end

class StationsIntegrationTest < Test::Unit::TestCase
  
  def test_should_use_the_stations_json_in_lib_by_default
    assert Stations.exists?('London St Pancras')
  end
  
end