require 'date'
require 'json'
class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  respond_to :html

  def preview 
    @lists = List.find(params[:id])
    respond_with(@list)
  end

  #Custom Function for importing the stock list info
  def import 
    List.import(params[:file])
    redirect_to lists_path, notice: "List Imported."
  end

  def index
    respond_to do |format|
      format.html
      if current_user
        format.json { render json: StockDatatable.new(List, view_context, current_user.id) }
      else
        format.json { render json: StockDatatable.new(List, view_context, nil) }
      end
    end
  end

  def show

   # helpers.yahoo_data
    #- Yahoo finance variables *keys -#
    # trade_date="2015-04-01", 
    # open="124.82",
    # high="125.12", 
    # low="123.10", 
    # close="124.25", 
    # volume="40359200", 
    # adjusted_close="124.25", 
    # symbol="AAPL"
    
    # Variables
    yahoo_client = YahooFinance::Client.new
    @lists = List.find(params[:id])
    get_quote = @lists.symbol    
    get_quote = get_quote.gsub('^','')    
    gon.pref0 = @lists.name
    t_sym = get_quote
    add = 0
    add = add.to_s


    # Get Stock history
    gon.master = yahoo_master_list = yahoo_client.historical_quotes(get_quote)

    gon.close = yahoo_master_list[0].close
    count = 0
    gon.test = $total = yahoo_master_list.size
    $data = []
    $high_val = []

    while count < $total  do
        #gon.pref0 = yahoo_master_list
        gon.open = yahoo_master_list[count].open
        gon.trade_date = yahoo_master_list[count].trade_date 
        high_value = yahoo_master_list[count].high

        #--- Parse string ---#
        parse_str = yahoo_master_list[count].trade_date
        item = parse_str.split('-')

        #--- convert string to int and use strftime to convert to seconds --#
        date1 = Date.new(item[0].to_i, item[1].to_i, item[2].to_i).strftime('%s')

        #--- convert 'date' to string to concat zeros (to convert milliseconds ot seconds) at the end ---#
        date2 = date1.to_s
        date3 = date2 + add * 3
        date_final = date3.to_i

        #--- final date with format "2015-04-01" into milliseconds for highstock usage---#
        $data.push([date_final,yahoo_master_list[count].close.to_f] )
        $high_val.push(high_value)

        count +=1
    end
    
    see = 0
    greatest = 0
    while see < $total do
      if $high_val[see].to_i > greatest
        greatest = $high_val[see].to_i
       end
       see += 1
    end
    
    gon.high = greatest + (greatest * 0.05)
    gon.data = $data.reverse

    # NOKO BLOCK ##
        
      $url = "http://finance.yahoo.com/q/h?s=" + get_quote + "&t=" + Date.current.to_s
      $doc = Nokogiri::HTML(open($url))      
      gon.get_size = lt = $doc.search('li a').size 
      $list_cite = $doc.search('ul li cite, h3 span').map(&:text)
      gon.get_link = $list_headlines = $doc.css('#yfncsumtab li a').each_with_object({}) { |n, h| h[n.text.strip] = n['href'] }
      #gon.get_link = $list_headlines.size

        @cites = []
        @dates = []

        gon.get_cite = $list_cite
        master_date = Array.new
        master_source = Array.new

        x = $list_cite.size-1
        year = "2016"

        for i in 0..x
          if $list_cite[i].include? "2016"
            year = "2016"
           
          end 

          if $list_cite[i].include? "2015"
            year = "2015"
            
          end
          master_date.push("#{$list_cite[i]}" + " " + "#{year}")
        end


         x = master_date.size-1
        year = "2016"

        for i in 0..x
          if master_date[i] =~ /\D{3} \d{1,2}[)] \d{4}/ 
            master_source.push(master_date[i])
          end
        end

        gon.tester = master_source
    
        master_source.each do |n| 
          p = n.gsub(")", '')
          s = p.split(',')
          q = s[0].split('(')
          @cites.push(q[0])
          @dates.push(s[1])
        end

        gon.date = @cites
  # END BLOCK ##
  end

  def new
    @list = List.new
    #respond_with(@list)
  end


  def edit
  end

  def create
    @list = List.new(list_params)
    @list.save
    redirect_to lists_path, notice: "List Created."
  #  respond_with(@list)
  end

  def update
    @list.update(list_params)
    redirect_to lists_path, notice: "List Created."
   # respond_with(@list)
  end

  def destroy
    @list.destroy
    redirect_to lists_path, notice: "List Created."
    #respond_with(@list)
  end

  private

    def sort_column
      List.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:symbol, :name, :market, :country, :ipo, :sector, :alive)
    end
end
