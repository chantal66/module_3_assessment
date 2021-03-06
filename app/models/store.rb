class Store

  attr_reader :name,
              :city,
              :distance,
              :phone,
              :type

  def initialize(store)
    @name     = store[:longName]
    @city     = store[:city]
    @distance = store[:distance]
    @phone    = store[:phone]
    @type     = store[:storeType]
  end

  def self.find_stores(zip)
    store = BestBuyService.find_stores(zip)
    store.map do |store|
      new(store)
    end
  end

  def self.total_stores(zip)
    BestBuyService.total_stores(zip)
  end

  def self.find_page(zip, page)
    stores = BestBuyService.find_page(zip, page)
    stores.map do |store|
      new(store)
    end
  end

end