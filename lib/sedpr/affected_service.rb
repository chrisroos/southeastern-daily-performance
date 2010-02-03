class AffectedService
  
  class UnidentifiedService < StandardError
    def initialize(reason_for_disruption, incident_text)
      super("Reason: #{reason_for_disruption}.  Incident text: #{incident_text}")
    end
  end
  
  attr_reader :reason_for_disruption
  attr_reader :scheduled_start_time, :scheduled_start_station, :scheduled_destination_station
  attr_reader :effect_on_service
  
  def initialize(reason_for_disruption, incident_text)
    @reason_for_disruption = reason_for_disruption
    unless incident_text =~ /(\d\d:\d\d) (.*?) \- (.*)/
      raise UnidentifiedService.new(reason_for_disruption, incident_text)
    end
    @scheduled_start_time, @scheduled_start_station = $1, $2
    destination_and_effect_on_service = $3
    if    destination_and_effect_on_service =~ /(.*) (cancelled)/
    elsif destination_and_effect_on_service =~ /(.*) (did not call.*)/
    elsif destination_and_effect_on_service =~ /(.*) (delayed by.*)/
    elsif destination_and_effect_on_service =~ /(.*) (started .*)/
    elsif destination_and_effect_on_service =~ /(.*) (terminated at.*)/
    else
      raise UnidentifiedService.new(reason_for_disruption, incident_text)
    end
    @scheduled_destination_station, @effect_on_service = $1, $2
  end
  
  def ==(incident)
    self.reason_for_disruption         == incident.reason_for_disruption and
    self.scheduled_start_time          == incident.scheduled_start_time and
    self.scheduled_start_station       == incident.scheduled_start_station and
    self.scheduled_destination_station == incident.scheduled_destination_station and
    self.effect_on_service             == incident.effect_on_service
  end
  
end