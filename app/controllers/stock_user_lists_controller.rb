class StockUserListsController < ApplicationController
  before_action :set_stock_user_list, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def index
    yahoo_client = YahooFinance::Client.new

    @stock_user_lists = StockUserList.all
    yahoo_master_list = []
   
    $master_array = []
    check = []
    gon.master_data = []
    stock_list = []
    add = 0
    add = add.to_s
    tracker =0

    gon.user = @cur_user = current_user.id
      @stock_user_lists.each do |stock_user_list| 
       if stock_user_list.users_id == @cur_user
           stock_list.push(stock_user_list.stock_name)
           gon.vars =  stock_user_list.stock_name
       end 
    end
    
    gon.master_list = stock_list
      while tracker < stock_list.size
        $data = []
        gon.index = var = stock_list[tracker]
        gon.master = yahoo_master_list = yahoo_client.historical_quotes(var)
        count = 0 
          while count < yahoo_master_list.size
              # Parse string ---#
              parse_str = yahoo_master_list[count].trade_date
              item = parse_str.split('-')
              # Convert string to int and use strftime to convert to seconds ---#
              date1 = Date.new(item[0].to_i, item[1].to_i, item[2].to_i).strftime('%s')
              # Convert 'date' to string to concat zeros (to convert milliseconds ot seconds) at the end ---#
              date2 = date1.to_s
              date3 = date2 + add * 3
              date_final = date3.to_i
              # Final date with format "2015-04-01" into milliseconds for highstock usage ---#
              $data.push([date_final,yahoo_master_list[count].close.to_f] )            
              count +=1
          end
        gon.data = $data.reverse
       
        size = gon.data.size
        gon.check = check.push(gon.data[size-1])
       
        $master_array.push(gon.data)
        tracker +=1
      end
      gon.master_data = $master_array
  end

  def show
  end

  def new
    redirect_to stock_user_lists_path
  end

  def edit
  end

  def create
    @stock_user_list = StockUserList.new(stock_user_list_params)
    @stock_user_list.save
    
    respond_to do |format|
      format.html {redirect_to(:back)}
      format.js
    end
  end

  def update
    @stock_user_list.update(stock_user_list_params)
    redirect_to stock_user_lists_path
  end

  def destroy
    @stock_user_list.destroy
    redirect_to stock_user_lists_path
  end

  private
    def set_stock_user_list
      @stock_user_list = StockUserList.find(params[:id])
    end

    def stock_user_list_params
      params.require(:stock_user_list).permit(:lists_id, :users_id, :stock_name)
    end
end
