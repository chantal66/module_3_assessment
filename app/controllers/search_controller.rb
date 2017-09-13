class SearchController < ApplicationController
  def index
    @zip = params['search']
     @conn = Faraday.new(url: "https://api.bestbuy.com") do |faraday|
         faraday.headers["X-API-KEY"] = ENV["best_buy_key"]
         faraday.adapter Faraday.default_adapter
     end

     response = @conn.get("v1/stores(area(#{@zip},25))?format=json&show=storeType,longName,city,distance,phone&apiKey=#{ENV['best_buy_key']}")

     results = JSON.parse(response.body, symbolize_names: true)[:stores]

     @results = results.map do |store|
      Store.new(store)
     end

    @total = JSON.parse(response.body, symbolize_names: true)[:total]
    # binding.pry
  end
end