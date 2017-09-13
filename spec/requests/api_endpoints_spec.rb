require 'rails_helper'

RSpec.describe 'Items API Endpoints' do
  context 'Get api/v1/items' do
    it 'sends all items' do
      items = create_list(:item, 3)

      get '/api/v1/items'

      items = JSON.parse(response.body)
      item = items.first

      expect(response).to be_success

      expect(response).to have_http_status(200)
      expect(items.count).to eq(3)
      expect(item).to have_key 'id'
      expect(item).to have_key 'name'
      expect(item).to have_key 'description'
      expect(item).to have_key 'image_url'
      expect(item['name']).to eq('Default Name')
      expect(item['description']).to eq('Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
      expect(item).not_to have_key 'created_at'
      expect(item).not_to have_key 'updated_at'
    end
  end

  context 'GET api/v1/items/:id' do
    it 'send 1 item' do
      item = create(:item)

      get "/api/v1/items/#{item.id}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(item).to be_a Hash
      expect(item).to have_key 'id'
      expect(item).to have_key 'name'
      expect(item).to have_key 'description'
      expect(item).to have_key 'image_url'
      expect(item['name']).to eq('Default Name')
      expect(item['description']).to eq('Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
      expect(item).not_to have_key 'created_at'
      expect(item).not_to have_key 'updated_at'
    end
  end

  context 'POST api/v1/items' do
    it 'can create an item' do
      item_params = { item: {
          name: 'Test Name',
          description: 'Lorem Ipsum',
          image_url: 'image.jpg'
      }}

      expect {
        post '/api/v1/items/', item_params
      }.to change{Item.count}.by(1)

      item = JSON.parse(response.body)
      expect(response).to have_http_status(201)
      expect(item).to be_a Hash
      expect(item).to have_key 'name'
      expect(item).to have_key 'description'
      expect(item).to have_key 'image_url'
      expect(item).not_to have_key 'created_at'
      expect(item).not_to have_key 'updated_at'
      expect(item['name']).to eq('Test Name')
      expect(item['description']).to eq('Lorem Ipsum')
    end
  end
end