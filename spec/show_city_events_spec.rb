require_relative '../lib/calendar/event'

describe 'Show events in the city' do
  let(:today) {Date.today}
  let(:a_title) {'irrelevant title'}
  context 'when querying events in next 30 days' do
    let(:tomorrow_event_title) {'tomorrow event title'}
    let(:past_event_title) {'past event title'}
    let(:greater_than_30_days_event_title) {'greater than 30 days event title'}
    let(:tomorrow) {Date.today + 1}
    let(:yesterday) {Date.today - 1}

    before(:each) do
      Event.destroy_all

      Event.create(title: tomorrow_event_title, date: tomorrow)
      Event.create(title: a_title, date: today)
      Event.create(title: past_event_title, date: yesterday)
      Event.create(title: greater_than_30_days_event_title, date: today + 31)

      get '/'
    end

    it 'is successful' do
      expect(last_response).to be_ok
    end

    context 'when returning events' do
      it 'does not contain past events' do
        expect(last_response.body).not_to include(past_event_title)
      end

      it 'does not contains events beyond 30 days' do
        expect(last_response.body).not_to include(greater_than_30_days_event_title)
      end

      it 'contains events within 30 days' do
        expect(last_response.body).to include(a_title)
      end

      it 'returns new events first' do
        today_event_order = last_response.body.index(a_title)
        tomorrow_event_order = last_response.body.index(tomorrow_event_title)

        expect(today_event_order).to be <= tomorrow_event_order
      end
    end
  end

  context 'when querying an detail event' do
    before (:each) do
      event = Event.create(title: a_title, date: (today + 5))
      get "/event/#{event.id}"
    end

    it 'is succesful' do
     expect(last_response).to be_ok
    end

    it 'should contain the event title' do
      expect(last_response.body).to include(a_title)
    end
  end
end
