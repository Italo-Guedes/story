Rails.application.reloader.to_prepare do
  ActiveSupport::TimeZone::MAPPING['Fernando de Noronha'] = 'America/Noronha'
  ActiveSupport::TimeZone::MAPPING['Amazônia'] = 'America/Manaus'
  ActiveSupport::TimeZone::MAPPING['Acre'] = 'America/Rio_Branco'
  ActiveSupport::TimeZone.instance_variable_set('@zones', nil)
  ActiveSupport::TimeZone.instance_variable_set('@zones_map', nil)

  module ActiveSupport
    class TimeZone
      def self.br_zones
        @br_zones ||= all.find_all { |z| z.name =~ /Brasilia|Noronha|Amazônia|Acre/ }
      end
    end
  end
end