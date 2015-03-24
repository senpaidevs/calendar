require_relative '../event'

describe 'Show events in the city' do
  context 'when querying events in next 30 days' do
    let(:a_title) {'irrelevant title'}

    before(:all) do
      DataMapper.auto_migrate!
    end

    before(:each) do
      Event.new(title: a_title).save

      get '/'
    end

    it 'responds success' do
      expect(last_response).to be_ok
    end

    it 'returns events' do
      expect(last_response.body).to include(a_title)
    end
  end
end
