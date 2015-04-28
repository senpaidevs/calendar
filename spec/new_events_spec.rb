require_relative '../lib/calendar/event'

describe 'Create a new event' do
  context 'when showing the form' do
    it "is succesful" do
      get '/events/new'
      expect(last_response).to be_ok
    end
  end

  context 'when creating an event' do
    let (:a_title){'test title'}
    let (:a_description){'test description'}

    before(:each) do
      post '/events', params={:title => a_title, :description => a_description}
    end

    it 'returns succesful response' do
      expect(last_response).to be_ok
    end

    it 'is saved in the database' do
      event = Event.last 
      expect(event.title).to be == a_title
      expect(event.description).to be == a_description
    end

  end
end

describe 'Save an event' do
  
  it 'should generate geolocation if the address exists' do
    event = Event.new(:address => 'Zaragoza')
    event.save
    expect(event.lat).not_to be_nil
    expect(event.long).not_to be_nil
  end
end
