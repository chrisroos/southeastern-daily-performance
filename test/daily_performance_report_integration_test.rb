require 'test_helper'
require 'daily_performance_report'

class DailyPerformanceReportIntegrationTest < Test::Unit::TestCase
  
  FIXTURES_DIR = File.join(File.dirname(__FILE__), 'fixtures')
  
  def test_should_convert_the_daily_performance_report_from_html_into_csv
    html_report      = File.read(File.join(FIXTURES_DIR, 'se-2010-01-27.html'))
    csv_report       = File.read(File.join(FIXTURES_DIR, 'se-2010-01-27.csv'))
    generated_report = DailyPerformanceReport.new(html_report).to_csv

    original_lines  = csv_report.split("\n")
    generated_lines = generated_report.split("\n")
    
    assert_equal original_lines.length, generated_lines.length
    original_lines.each_with_index do |line, index|
      assert_equal line, generated_lines[index]
    end
  end
  
end