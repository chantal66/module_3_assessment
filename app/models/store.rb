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

  # def self.find_stores(zip)
  #   stores = BestBuyService.find_stores(zip)
  #   stores.map do |store|
  #     new(store)
  #   end
  # end
end