require 'test_helper'
require 'affected_service'

class AffectedServiceTest < Test::Unit::TestCase
  
  def test_should_provide_read_access_to_the_reason_for_the_disruption
    affected_service = AffectedService.new('Signal problem', '')
    assert_equal 'Signal problem', affected_service.reason_for_disruption
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
  
  def test_should_deal_with_services_that_start_elsewhere_and_terminate_early
    affected_service = AffectedService.new('', "00:00 origin - destination started Tonbridge and terminated at Tunbridge Wells")
    assert_equal 'started Tonbridge and terminated at Tunbridge Wells', affected_service.effect_on_service
  end
  
end

class AffectedServiceEqualityTest < Test::Unit::TestCase
  
  def test_should_be_equal_to_another_affected_service_that_has_the_same_reason_and_service_details
    affected_service_1 = AffectedService.new('Signal problem', '00:00 origin - destination cancelled')
    affected_service_2 = AffectedService.new('Signal problem', '00:00 origin - destination cancelled')
    assert_equal affected_service_1, affected_service_2
  end
  
end