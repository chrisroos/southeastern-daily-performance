module SoutheasternDailyPerformance
  class AffectedService
  
    attr_reader :reason_for_disruption
    attr_reader :scheduled_start_time, :scheduled_start_station, :scheduled_destination_station
    attr_reader :effect_on_service
  
    def initialize(reason_for_disruption, incident_text)
      @reason_for_disruption = reason_for_disruption
      if incident_text =~ /(\d\d:\d\d) (.*?) ?(?:-|to|\?) (.*)/
        @scheduled_start_time, @scheduled_start_station = $1, $2
        destination_and_effect_on_service = $3
        @scheduled_start_station.gsub!(/[^a-zA-Z ]/, '')
        reasons = [
          'cancelled', 'started', 'delayed by', 'did not call', 'terminated at', 'diverted'
        ]
        matches = reasons.collect do |reason|
          destination_and_effect_on_service =~ /#{reason}/i
        end
        if matches.compact.min && reason = reasons[matches.index(matches.compact.min)]
          destination_and_effect_on_service =~ /(.*) (#{reason}.*)/i
        else
          unless destination_and_effect_on_service.split(' ').length == 1
            warn "Warning. Unknown, or missing, affect on service: '#{incident_text}'"
          end
          destination_and_effect_on_service =~ /(.*)/
        end
        @scheduled_destination_station, @effect_on_service = $1, ($2||'')
      else
        warn "Warning. Cannot parse service details: '#{incident_text}'"
      end
    end
  
    def ==(incident)
      self.reason_for_disruption         == incident.reason_for_disruption and
      self.scheduled_start_time          == incident.scheduled_start_time and
      self.scheduled_start_station       == incident.scheduled_start_station and
      self.scheduled_destination_station == incident.scheduled_destination_station and
      self.effect_on_service             == incident.effect_on_service
    end
  
  end
end