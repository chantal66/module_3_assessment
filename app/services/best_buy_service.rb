class BestBuyService

  attr_reader :zip
  def initialize(zip)
    @zip = zip
    @conn = Faraday.new(url: "https://api.bestbuy.com") do |faraday|
      faraday.headers["X-API-KEY"] = ENV["best_buy_key"]
      faraday.adapter Faraday.default_adapter
    end
  end

  def find_stores
    get_url("v1/stores(area(#{@zip},25))?format=json&show=storeType,longName,city,distance,phone&apiKey=#{ENV['best_buy_key']}")
  end

  def get_url(url)
    response = @conn.get(url)
    JSON.parse(response.body, symbolize_names: true)[:stores]
  end

  def self.find_stores(zip)
    new(zip).find_stores
  end
end