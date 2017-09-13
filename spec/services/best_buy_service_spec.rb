require 'rails_helper'

RSpec.describe BestBuyService do
  it 'returns a total number of stores found' do
    VCR.use_cassette('services/user_can_search_store') do
      stores = BestBuyService.find_stores('80202')
      store = stores.first

      expect(stores.count).to eq(10)
      expect(store[:storeType]).to eq('Mobile SAS')
      expect(store[:longName]).to eq('Cherry Creek Shopping Center')
      expect(store[:city]).to eq('Denver')
      expect(store[:distance]).to eq(3.45)
      expect(store[:phone]).to eq('303-270-9189')
    end
  end

  it 'returns a total number of stores found' do
    VCR.use_cassette('services/user_can_search_store') do
      total_stores = BestBuyService.total_stores('80202')

      expect(total_stores).to eq(17)
    end
  end
end