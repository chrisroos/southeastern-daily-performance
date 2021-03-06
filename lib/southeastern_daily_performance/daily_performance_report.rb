require 'hpricot'
require 'csv'
require 'date'

module SoutheasternDailyPerformance
  class DailyPerformanceReport
  
    def initialize(html)
      html = html.gsub(%r!&nbsp;!, ' ')
      @doc = Hpricot(html)
    end
  
    def date
      date = (@doc/'h1').inner_text
      date.gsub!(/\?/, ' ')
      if date =~ /(.+?) (\d+) (.+)/
      elsif (@doc/'h2').inner_text =~ /(.+?) (\d+) (.+)/
      end
      day_name, day, month_name = $1, $2, $3
      date = [day, month_name[0..2].downcase, '2010'].join('-')
      Date.parse(date)
    end
  
    def scheduled_services
      report[/(\d+) (train )?services were scheduled/, 1].to_i
    end
  
    def actual_services
      report[/of which (\d+) ran/, 1].to_i
    end
  
    def services_within_five_minutes_of_schedule
      report[/(\d+\.?\d+?)% of services ran within 5 minutes of schedule/, 1].to_f
    end
  
    def affected_services
      AffectedServicesReport.new(report_container.inner_html).affected_services
    end
  
    def to_csv(type=nil)
      if "#{type}" == 'overview'
        CSV.generate_line [date, scheduled_services, actual_services, services_within_five_minutes_of_schedule]
      else
        affected_services.collect do |service|
          CSV.generate_line [date, service.reason_for_disruption, service.scheduled_start_time, service.scheduled_start_station, service.scheduled_destination_station, service.effect_on_service]
        end.join("\n")
      end
    end
  
    private
  
      def report
        report_container.inner_text
      end
    
      def report_container
        if (@doc/'#mainblock').any?
          (@doc/'h1').first.next_sibling
        else
          (@doc/'h1').first.parent.next_sibling
        end
      end
    
  end
end