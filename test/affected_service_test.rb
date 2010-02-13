require 'test_helper'
require 'affected_service'

class AffectedServiceTest < Test::Unit::TestCase
  
  def test_should_provide_read_access_to_the_reason_for_the_disruption
    affected_service = AffectedService.new('Signal problem', '00:00 origin - destination cancelled')
    assert_equal 'Signal problem', affected_service.reason_for_disruption
  end
  
  def test_should_emit_warning_if_we_cannot_parse_the_incident_data
    AffectedService.any_instance.expects(:warn).with("Warning. Cannot parse service details: 'foo bar baz'")
    AffectedService.new('', 'foo bar baz')
  end
  
end

class AffectedServiceStrangeSeperatorsTest < Test::Unit::TestCase
  
  def test_should_deal_with_a_question_mark_as_a_seperator
    affected_service = AffectedService.new('', "00:00 origin ? destination cancelled")
    
    assert_equal '00:00',       affected_service.scheduled_start_time
    assert_equal 'origin',      affected_service.scheduled_start_station
    assert_equal 'destination', affected_service.scheduled_destination_station
  end
  
  def test_should_deal_with_a_lack_of_space_between_the_hyphen_and_origin_stations
    affected_service = AffectedService.new('', "00:00 origin- destination cancelled")
    
    assert_equal '00:00',       affected_service.scheduled_start_time
    assert_equal 'origin',      affected_service.scheduled_start_station
    assert_equal 'destination', affected_service.scheduled_destination_station
  end
  
  def test_should_deal_with_an_extraneous_question_mark_and_lack_of_space_between_the_hyphen_and_origin_stations
    affected_service = AffectedService.new('', "00:00 origin?- destination cancelled")
    
    assert_equal '00:00',       affected_service.scheduled_start_time
    assert_equal 'origin',      affected_service.scheduled_start_station
    assert_equal 'destination', affected_service.scheduled_destination_station
  end
  
end

class AffectedServiceSeparatedByHyphensTest < Test::Unit::TestCase
  
  def setup
    @affected_service = AffectedService.new('', "00:00 origin - destination cancelled")
  end
  
  def test_should_parse_the_time_of_the_service
    assert_equal '00:00', @affected_service.scheduled_start_time
  end
  
  def test_should_parse_the_origin_station
    assert_equal 'origin', @affected_service.scheduled_start_station
  end
  
  def test_should_parse_the_destination_station
    assert_equal 'destination', @affected_service.scheduled_destination_station
  end
  
end

class AffectedServiceSeparatedByToTest < Test::Unit::TestCase
  
  def setup
    @affected_service = AffectedService.new('', "00:00 origin to destination cancelled")
  end
  
  def test_should_parse_the_time_of_the_service
    assert_equal '00:00', @affected_service.scheduled_start_time
  end
  
  def test_should_parse_the_origin_station
    assert_equal 'origin', @affected_service.scheduled_start_station
  end
  
  def test_should_parse_the_destination_station
    assert_equal 'destination', @affected_service.scheduled_destination_station
  end
  
end

class AffectedServiceOutcomeTest < Test::Unit::TestCase
  
  def test_should_assume_a_one_word_destination_station_with_no_outcome_and_therefore_not_warn
    AffectedService.any_instance.expects(:warn).never
    affected_service = AffectedService.new('', "00:00 origin - destination")
    
    assert_equal 'destination', affected_service.scheduled_destination_station
    assert_equal '', affected_service.effect_on_service
  end
  
  def test_should_warn_that_we_cannot_parse_the_destination_station_and_outcome
    AffectedService.any_instance.expects(:warn).with("Warning. Unknown, or missing, affect on service: '00:00 origin - destination and reason'")
    affected_service = AffectedService.new('', "00:00 origin - destination and reason")
    
    assert_equal 'destination and reason', affected_service.scheduled_destination_station
    assert_equal '', affected_service.effect_on_service
  end
  
  def test_should_deal_with_cancellations
    affected_service = AffectedService.new('', "00:00 origin - destination cancelled")
    assert_equal 'cancelled', affected_service.effect_on_service
  end
  
  def test_should_deal_with_services_that_miss_stations
    affected_service = AffectedService.new('', "00:00 origin - destination did not call at Woolwich Dockyard")
    assert_equal 'did not call at Woolwich Dockyard', affected_service.effect_on_service
  end
  
  def test_should_deal_with_services_that_are_delayed
    affected_service = AffectedService.new('', "00:00 origin - destination delayed by 11 minutes")
    assert_equal 'delayed by 11 minutes', affected_service.effect_on_service
  end
  
  def test_should_deal_with_services_that_terminate_early
    affected_service = AffectedService.new('', "00:00 origin - destination terminated at London Bridge")
    assert_equal 'terminated at London Bridge', affected_service.effect_on_service
  end
  
  def test_should_deal_with_services_that_start_elsewhere
    affected_service = AffectedService.new('', "00:00 origin - destination started at London Bridge")
    assert_equal 'started at London Bridge', affected_service.effect_on_service
  end
  
  def test_should_deal_with_diverted_services
    affected_service = AffectedService.new('', "00:00 origin - destination diverted to Barnehurst")
    assert_equal 'diverted to Barnehurst', affected_service.effect_on_service
  end
  
  def test_should_deal_with_diverted_services_and_not_care_about_case
    affected_service = AffectedService.new('', "00:00 origin - destination Diverted to Barnehurst")
    assert_equal 'Diverted to Barnehurst', affected_service.effect_on_service
  end
  
  def test_should_deal_with_services_that_start_elsewhere_and_are_delayed
    affected_service = AffectedService.new('', '00:00 origin - destination started at London Bridge and delayed by 15 minutes')
    assert_equal 'started at London Bridge and delayed by 15 minutes', affected_service.effect_on_service
  end
  
  def test_should_deal_with_services_that_start_elsewhere_and_terminate_early
    affected_service = AffectedService.new('', "00:00 origin - destination started Tonbridge and terminated at Tunbridge Wells")
    assert_equal 'started Tonbridge and terminated at Tunbridge Wells', affected_service.effect_on_service
  end
  
  def test_should_deal_with_services_that_are_delayed_and_miss_stations
    affected_service = AffectedService.new('', '00:00 origin - destination delayed by 10 minutes and did not call at Woolwich Dockyard')
    assert_equal 'delayed by 10 minutes and did not call at Woolwich Dockyard', affected_service.effect_on_service
  end
  
  def test_should_deal_with_services_that_are_delayed_and_start_elsewhere
    affected_service = AffectedService.new('', '00:00 origin - destination delayed by 11 minutes and started at Dartford')
    assert_equal 'delayed by 11 minutes and started at Dartford', affected_service.effect_on_service
  end
  
end

class AffectedServiceEqualityTest < Test::Unit::TestCase
  
  def test_should_be_equal_to_another_affected_service_that_has_the_same_reason_and_service_details
    affected_service_1 = AffectedService.new('Signal problem', '00:00 origin - destination cancelled')
    affected_service_2 = AffectedService.new('Signal problem', '00:00 origin - destination cancelled')
    assert_equal affected_service_1, affected_service_2
  end
  
end