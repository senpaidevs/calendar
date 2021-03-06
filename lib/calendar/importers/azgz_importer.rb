require 'json'
require 'open-uri'
require 'date'

require_relative '../event'

class AZgzImporter
  def import
    find_events.each do |event|
      import_next_event_for(event)
    end
  end

  private

  def find_events
    open(events_url) do |payload|
      response = JSON.parse(payload.read)
      response['response']['docs']
    end
  end

  def import_next_event_for(event)
    count = Event.where(url: event['uri']).count

    if(count==0)
      Event.create(
        title: event['title'],
        address: event['direccionlugar_t'],
        place: event['nombrelugar_t'],
        description: event['description_t'],
        lat: event['coordenadas_p_0_coordinate'],
        long: event['coordenadas_p_1_coordinate'],
        date: DateTime.parse(Date.parse(event['fechaInicio_dt']).to_s + " " + (event['horaInicio_t'] || '00:00')),
        url: event['uri']
      )
    end
  end

  def events_url
    "http://www.zaragoza.es/buscador/select?wt=json&q=-tipocontenido_s:estatico%20AND%20category:Actividades%20AND%20fechaInicio_dt:[NOW%20TO%20NOW%2B1MONTH]&fq=temas_smultiple:(%22Tecnologia%20y%20Ciudadania%22),(%22tecnologia%20y%20ciudadania%22)"
  end
end

