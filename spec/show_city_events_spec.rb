require_relative '../event'

describe 'Show events in the city' do
  context 'when querying events in next 30 days' do
    let(:a_title) {'irrelevant title'}
    let(:past_event_title) {'past event title'}
    let(:greater_than_30_days_event_title) {'greater than 30 days event title'}
    let(:today) {Date.today}
    let(:yesterday) {Date.today - 1}

    before(:each) do
      DataMapper.auto_migrate!

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
    end
  end
end
