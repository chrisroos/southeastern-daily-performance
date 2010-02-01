require 'test/unit'


require 'hpricot'
class Parser
  def self.parse(html)
    doc = Hpricot(html)
  end
end

class ParserTest < Test::Unit::TestCase
  
  def test_should_parse_html_report
    html_report = File.read('se-2010-01-27.html')
    csv_report  = File.read('se-2010-01-27.csv')
    
    assert_equal csv_report, Parser.parse(html_report)
  end
  
end