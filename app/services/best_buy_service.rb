class BestBuyService
  
  def initialize(zip)
    @zip = zip
    @conn = Faraday.new(url: "https://api.bestbuy.com") do |faraday|
      faraday.headers["X-API-KEY"] = ENV["best_buy_key"]
      faraday.adapter Faraday.default_adapter
    end
  end

  def find_stores
    get_url("v1/stores(area(#{zip},25))?format=json&show=storeType,longName,city,distance,phone&apiKey=#{ENV['best_buy_key']}")
  end

  def get_url(url)
    response = @conn.get(url)
    JSON.parse(response.body, symbolize_names: true)[:stores]
  end

  def self.find_stores(zip)
    new(zip).find_stores
  end

  def total_stores
    get_url_for_total("v1/stores(area(#{zip},25))?format=json&show=storeType,longName,city,distance,phone&apiKey=#{ENV['best_buy_key']}")
  end
  
  def get_url_for_total(url)
    response = @conn.get(url)
    JSON.parse(response.body, symbolize_names: true)[:total]
  end

  def self.total_stores(zip)
    new(zip).total_stores
  end

  def find_page
    get_url_for_page("v1/stores(area(#{zip},25))?format=json&show=storeType,longName,city,distance,phone&apiKey=#{ENV['best_buy_key']}")
  end

  def get_url_for_page(url)
    response = @conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.find_page(zip, page)
    new(zip, page).find_page
  end

  private

  attr_reader :zip
end