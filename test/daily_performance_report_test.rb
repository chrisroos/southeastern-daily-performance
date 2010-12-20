require 'test_helper'
require 'csv'

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
      <p>
        <strong>Fatality at Wandsworth Road</strong>
        <br />
        08:54 Swanley - Victoria
      </p>
    </div>
    EndHtmlReport
    
    @report = DailyPerformanceReport.new(html)
  end
  
  def test_should_parse_the_date_from_the_level_1_heading
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
    assert_equal 5, @report.affected_services.length
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
  
  def test_should_parse_the_fifth_service_disruption
    expected_incident = AffectedService.new('Fatality at Wandsworth Road', '08:54 Swanley - Victoria')
    assert_equal expected_incident, @report.affected_services[4]
  end
  
end

class DailyPerformanceReportNewFormatTest < Test::Unit::TestCase
  
  def setup
    html =<<-End
<div class="content" id="content_975">
  <h1>Daily performance information</h1>
  <div class="float_reset"></div>
</div>
<div class="content" id="content_976">
  <h2>Sunday 31 January&nbsp;</h2>
  <p>
    Whether you're one of our regular commuters, travelling on business or for leisure, you expect Southeastern trains to be punctual and reliable. 
  </p>
  <p>
    On Sunday 31 January, <strong>1047</strong> train services were scheduled to operate of which <strong>1039</strong> ran.
  </p>
  <p>
    We aim to run all our trains on time, however there are times when this isn't possible. On this day <strong>96%</strong> of services ran within 5 minutes of schedule.
  </p>
    <p class="bordered">The following services were diverted, cancelled or delayed by over 10 minutes:
  </p>
</div>
    End
    @report = DailyPerformanceReport.new(html)
  end
  
  def test_should_parse_the_date_from_the_level_2_heading
    assert_equal Date.parse('2010-01-31'), @report.date
  end
  
  def test_should_parse_the_number_of_scheduled_services
    assert_equal 1047, @report.scheduled_services
  end
  
  def test_should_parse_the_number_of_actual_services
    assert_equal 1039, @report.actual_services
  end
  
  def test_should_parse_the_percentage_or_trains_that_ran_within_5_minutes_of_schedule
    assert_equal 96, @report.services_within_five_minutes_of_schedule
  end
  
end

class DailyPerformanceReport15thAprilOnwardTest < Test::Unit::TestCase
  
  def setup
    html =<<-End
<div id="mainblock">
  <div id="middle">
    <h1>Thursday 15 April</h1>
    <div class="content">
    <p>Whether you're one of our regular commuters, travelling on business or for leisure, you expect Southeastern trains to be punctual and reliable.</p>
    <p>On Thursday 15 April <strong>2055</strong> services were scheduled to operate of which <strong>2041</strong> ran.</p>
    <p>We aim to run all our trains on time, however there are times when this isn't possible. On this day <strong>96%</strong> of services ran within 5 minutes of schedule.</p>
    <h4 class="primarybh4">The following services were diverted, cancelled or delayed by over 10 mins:</h4>
  </div>
</div>
    End
    @report = DailyPerformanceReport.new(html)
  end
  
  def test_should_parse_the_date_from_the_level_1_heading
    assert_equal Date.parse('2010-04-15'), @report.date
  end
  
  def test_should_parse_the_number_of_scheduled_services
    assert_equal 2055, @report.scheduled_services
  end
  
  def test_should_parse_the_number_of_actual_services
    assert_equal 2041, @report.actual_services
  end
  
  def test_should_parse_the_percentage_or_trains_that_ran_within_5_minutes_of_schedule
    assert_equal 96, @report.services_within_five_minutes_of_schedule
  end
  
end

class DailyPerformanceReportPercentageServicesWithinFiveMinutesOfScheduleTest < Test::Unit::TestCase
  
  def setup
    html =<<-End
<div id="mainblock">
  <div id="middle">
    <h1>Thursday 15 April</h1>
    <div class="content">
    <p>Whether you're one of our regular commuters, travelling on business or for leisure, you expect Southeastern trains to be punctual and reliable.</p>
    <p>On Thursday 15 April <strong>2055</strong> services were scheduled to operate of which <strong>2041</strong> ran.</p>
    <p>We aim to run all our trains on time, however there are times when this isn't possible. On this day <strong>96.1%</strong> of services ran within 5 minutes of schedule.</p>
    <h4 class="primarybh4">The following services were diverted, cancelled or delayed by over 10 mins:</h4>
  </div>
</div>
    End
    @report = DailyPerformanceReport.new(html)
  end
  
  def test_should_parse_the_decimal_percentage_or_trains_that_ran_within_5_minutes_of_schedule
    assert_equal 96.1, @report.services_within_five_minutes_of_schedule
  end
  
end

class DailyPerformanceReportCsvTest < Test::Unit::TestCase
  
  def setup
    html = <<-EndHtmlReport
    <div class="content" id="content_7116">
      <h1>Wednesday&nbsp;27&nbsp;January</h1>    <div class="float_reset"></div>
    </div>
    <div class="content" id="content_7114">
      <p>
        <strong>Points failure at Slade Green</strong>
        <br />
        13:54 Gillingham to Charing Cross started Rochester,&nbsp; delayed by 15 minutes and terminated London Bridge
    EndHtmlReport
    @report = DailyPerformanceReport.new(html).to_csv
  end
  
  def test_should_quote_the_reason_in_the_csv_output
    date, reason, time, origin, destination, reason = CSV.parse(@report).first
    assert_equal 'started Rochester,  delayed by 15 minutes and terminated London Bridge', reason
  end
  
end