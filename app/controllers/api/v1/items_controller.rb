class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:destroy]

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

  def destroy
    if @item
      @item.destroy
      render json: {success:"Item deleted"}, status: 204
    else
      render json: {error: "Item not found"}, status: 404
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :image_url)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end