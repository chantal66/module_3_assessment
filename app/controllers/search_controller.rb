class SearchController < ApplicationController
  def index
    zip = params['search']
    if params['search']
      @results = Store.find_stores(zip)
    end

    # @total = JSON.parse(response.body, symbolize_names: true)[:total]

  end
end