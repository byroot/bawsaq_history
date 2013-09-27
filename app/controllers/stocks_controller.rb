class StocksController < ApplicationController
  respond_to :json

  def index
    @stocks = stocks.all
    render json: @stocks.to_json(include: :price_points)
  end

  def show
    @stock = stocks.find_by_company_code!(params[:id])
    render json: @stock.to_json(include: :price_points)
  end

  private

  def stocks
    Stock.includes(:price_points)
  end

end
