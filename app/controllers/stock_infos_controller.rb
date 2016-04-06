class StockInfosController < ApplicationController
	respond_to :json

  def index
    respond_with StockInfo.all
  end

  def destroy
   respond_with StockInfo.destroy(params[:id])
  end

  def create
    respond_with StockInfo.create(stock_info_params)
  end

  private
    def stock_info_params
      params.require(:stock_info).permit(:symbol, :name, :bid, :ask, :year_low, :year_high)
    end

end
