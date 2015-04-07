require 'json'
require 'open-uri'

require_relative 'event'

class MeetupImporter
  def initialize(member_id, key)
    @member_id = member_id
    @key = key
  end

  def import
    find_groups.each do |group|
      import_next_event_for(group) if has_next_event?(group)
    end
  end

  private

  def find_groups
    open(groups_url) do |payload|
      JSON.parse(payload.read)
    end
  end

  def groups_url
    "https://api.meetup.com/find/groups?&sign=true&photo-host=public&zip=50000&country=es&location=zaragoza&category=34&page=20&member_id=#{@member_id}&key=#{@key}"
  end

  def has_next_event?(group)
    group.include?('next_event')
  end

  def import_next_event_for(group)
    event_id = group['next_event']['id']
    event = find_event_by_id(event_id)

    Event.create(
      title: event['name'],
      description: event['description'],
      date: Time.at(event['time'].to_i/1000).to_datetime
    )
  end

  def find_event_by_id(event_id)
    open(event_url(event_id)) do |payload|
      JSON.parse(payload.read)
    end
  end

  def event_url(event_id)
    "https://api.meetup.com/2/event/#{event_id}?&sign=true&photo-host=public&page=20&member_id=#{@member_id}&key=#{@key}"
  end
end

