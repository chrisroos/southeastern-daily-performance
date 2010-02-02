require 'test_helper'
require 'daily_performance_report'

class DailyPerformanceReportTest < Test::Unit::TestCase
  
  def setup
    html = <<-EndHtmlReport
    <div class="content" id="content_7116">
      <h1>Wednesday&nbsp;27&nbsp;January</h1>    <div class="float_reset"></div>
    </div>
    <div class="content" id="content_7114">
      <p>
        Whether you're one of our regular commuters, travelling on business or for leisure, you expect Southeastern trains to be punctual and reliable. 
      </p>
      <p>
        On Wednesday 27 January, <strong>2049 </strong>train services were scheduled to operate of which <strong>2009 </strong>ran.
        <br /><br />
        We aim to run all our trains on time, however there are times when this isn't possible. On this day <strong>81%</strong> of services ran within 5 minutes of schedule. 
      </p>
      <p class="bordered">
        The following services were diverted, cancelled or delayed by over 10 minutes:
      </p>
      <p>
        <br />
        <strong>Points failure at Slade Green</strong>
        <br />
        15:54 Gillingham - Cannon St did not call at Woolwich Dockyard
        <br />
        18:34 Orpington - Cannon St delayed by 11 minutes
      </p>
      <p>
        <strong>Track circuit failure</strong>
        <br />
        05:50 Ashford - Victoria delayed by 20 minutes
        <br />
        07:36 Victoria - Ashford delayed by 10 minutes
      </p>
    </div>
    EndHtmlReport
    
    @report = DailyPerformanceReport.new(html)
  end
  
  def test_should_parse_the_date_from_the_heading
    assert_equal Date.parse('2010-01-27'), @report.date
  end
  
  def test_should_parse_the_number_of_scheduled_services
    assert_equal 2049, @report.scheduled_services
  end
  
  def test_should_parse_the_number_of_actual_services
    assert_equal 2009, @report.actual_services
  end
  
  def test_should_parse_the_percentage_or_trains_that_ran_within_5_minutes_of_schedule
    assert_equal 81, @report.services_within_five_minutes_of_schedule
  end
  
  def test_should_parse_the_number_of_affected_services
    assert_equal 4, @report.affected_services.length
  end
  
  def test_should_parse_the_first_service_disruption
    expected_incident = AffectedService.new('Points failure at Slade Green', '15:54 Gillingham - Cannon St did not call at Woolwich Dockyard')
    assert_equal expected_incident, @report.affected_services[0]
  end
  
  def test_should_parse_the_second_service_disruption
    expected_incident = AffectedService.new('Points failure at Slade Green', '18:34 Orpington - Cannon St delayed by 11 minutes')
    assert_equal expected_incident, @report.affected_services[1]
  end
  
  def test_should_parse_the_third_service_disruption
    expected_incident = AffectedService.new('Track circuit failure', '05:50 Ashford - Victoria delayed by 20 minutes')
    assert_equal expected_incident, @report.affected_services[2]
  end
  
  def test_should_parse_the_fourth_service_disruption
    expected_incident = AffectedService.new('Track circuit failure', '07:36 Victoria - Ashford delayed by 10 minutes')
    assert_equal expected_incident, @report.affected_services[3]
  end
  
end