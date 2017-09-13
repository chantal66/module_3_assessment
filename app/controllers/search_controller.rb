class SearchController < ApplicationController
  def index
    zip = params['search']
    if params['search']
      @results = Store.find_stores(zip)
      @total = Store.total_stores(zip)
    elsif params['page']
      @stores = Store.find_page(zip,page: params[:page])
    end
  end
end