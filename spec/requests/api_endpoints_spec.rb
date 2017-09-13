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
end