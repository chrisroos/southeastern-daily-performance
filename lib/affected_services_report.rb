require 'rubygems'
require 'hpricot'
require 'affected_service'

class AffectedServicesReport
  
  def initialize(html)
    @doc = Hpricot(html)
  end
  
  def affected_services
    @doc.search('*').collect do |elem|
      if elem.text? and incident_text = elem.inner_text[/\d\d:\d\d.*/]
        reason = find_previous_strong_element(elem).inner_text
        AffectedService.new(reason.strip, incident_text.strip)
      end
    end.compact
  end
  
  private
  
    def find_previous_strong_element(elem)
      return elem if (elem.respond_to?(:name) and elem.name == 'strong')
      find_previous_strong_element(elem.previous)
    end
  
end