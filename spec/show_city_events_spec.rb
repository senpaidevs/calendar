require_relative '../event'

describe 'Show events in the city' do
  context 'when querying events in next 30 days' do
    let(:a_title) {'irrelevant title'}
    let(:past_event_title) {'past event title'}
    let(:today) {Date.today}
    let(:yesterday) {Date.today - 1}

    before(:each) do
      DataMapper.auto_migrate!

      Event.create(title: a_title, date: today)
      Event.create(title: past_event_title, date: yesterday)

      get '/'
    end

    it 'is successful' do
      expect(last_response).to be_ok
    end

    context 'when returning events' do
      it 'does not contain past events' do
        expect(last_response.body).not_to include(past_event_title)
      end
    end
  end
end
