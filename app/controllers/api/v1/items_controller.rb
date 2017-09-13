class Api::V1::ItemsController < ApplicationController
  def index
    render json: Item.all
  end

  def show
    render json: Item.find(params[:id])
  end

  def create
    item = Item.create(item_params)
    if item.save
      render json: item, status: 201
    else
      render json: item.errors, status: 400
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :image_url)
  end
end