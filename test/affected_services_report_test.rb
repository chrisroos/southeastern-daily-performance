require 'test_helper'
require 'affected_services_report'

class AffectedServicesReportOneIncidentTest < Test::Unit::TestCase
  
  def setup
    html =<<-EndHtml
    <div>
      <p>
        <br />
        <strong>Train fault at Victoria <br/></strong>
        <br />
        06:59 Ramsgate - Cannon St delayed by 10 minutes
        <br />
        07:28 Rochester - Beckenham Junction cancelled
      </p>
    </div>
    EndHtml
    html.gsub!(/\n/, '')
    @affected_services_report = AffectedServicesReport.new(html)
  end
  
  def test_should_parse_the_number_of_affected_services
    assert_equal 2, @affected_services_report.affected_services.length
  end
  
  def test_should_parse_the_first_affected_service
    affected_service = AffectedService.new('Train fault at Victoria', '06:59 Ramsgate - Cannon St delayed by 10 minutes')
    assert_equal affected_service, @affected_services_report.affected_services.first
  end
  
  def test_should_parse_the_second_affected_service
    affected_service = AffectedService.new('Train fault at Victoria', '07:28 Rochester - Beckenham Junction cancelled')
    assert_equal affected_service, @affected_services_report.affected_services.last
  end
  
end

class AffectedServicesReportMultipleIncidentsTest < Test::Unit::TestCase
  
  def setup
    html =<<-EndHtml
    <div>
      <p>
        <br />
        <strong>Train fault at Victoria <br/></strong>
        <br />
        06:59 Ramsgate - Cannon St delayed by 10 minutes
      </p>
      <p>
        <br />
        <strong>Points failure at Slade Green <br/></strong>
        <br />
        15:54 Gillingham - Cannon St did not call at Woolwich Dockyard
      </p>
    </div>
    EndHtml
    html.gsub!(/\n/, '')
    @affected_services_report = AffectedServicesReport.new(html)
  end
  
  def test_should_parse_the_number_of_affected_services
    assert_equal 2, @affected_services_report.affected_services.length
  end
  
  def test_should_parse_the_first_affected_service
    affected_service = AffectedService.new('Train fault at Victoria', '06:59 Ramsgate - Cannon St delayed by 10 minutes')
    assert_equal affected_service, @affected_services_report.affected_services.first
  end
  
  def test_should_parse_the_second_affected_service
    affected_service = AffectedService.new('Points failure at Slade Green', '15:54 Gillingham - Cannon St did not call at Woolwich Dockyard')
    assert_equal affected_service, @affected_services_report.affected_services.last
  end
  
end

class AffectedServicesReportMultipleIncidentsWierdMarkupTest < Test::Unit::TestCase
  
  def setup
    html =<<-EndHtml
    <div>
      <p>
        <br />
        <strong>Track circuit failure <br/></strong>
        <br />
        05:50 Ashford - Victoria delayed by 20 minutes
        <br />
        <strong>Frozen points at Grove Park <br/></strong>
        <br />
        08:00 Slade Green - Charing Cross delayed by 10 minutes
      </p>
    </div>
    EndHtml
    html.gsub!(/\n/, '')
    @affected_services_report = AffectedServicesReport.new(html)
  end
  
  def test_should_parse_the_number_of_affected_services
    assert_equal 2, @affected_services_report.affected_services.length
  end
  
  def test_should_parse_the_first_affected_service
    affected_service = AffectedService.new('Track circuit failure', '05:50 Ashford - Victoria delayed by 20 minutes')
    assert_equal affected_service, @affected_services_report.affected_services.first
  end
  
  def test_should_parse_the_second_affected_service
    affected_service = AffectedService.new('Frozen points at Grove Park', '08:00 Slade Green - Charing Cross delayed by 10 minutes')
    assert_equal affected_service, @affected_services_report.affected_services.last
  end
  
end