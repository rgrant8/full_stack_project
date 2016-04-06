require 'date'
require 'json'
class AmexesController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  respond_to :html

  def preview 
    @amexes = Amex.find(params[:id])
    respond_with(@amex)
  end

  #Custom Function for importing the stock amex info
  def import 
    Amex.import(params[:file])
    redirect_to amexes_path, notice: "Amex Imported."
  end

  def index
    respond_to do |format|
      format.html
      if current_user
        format.json { render json: StockDatatable.new(Amex, view_context, current_user.id) }
      else
        format.json { render json: StockDatatable.new(Amex, view_context, nil) }
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
    @amexes = Amex.find(params[:id])
    get_quote = @amexes.symbol    
    get_quote = get_quote.gsub('^','')    
    gon.pref0 = @amexes.name
    gon.t_sym = get_quote
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
      $amex_cite = $doc.search('ul li cite, h3 span').map(&:text)
      gon.get_link = $amex_headlines = $doc.css('#yfncsumtab li a').each_with_object({}) { |n, h| h[n.text.strip] = n['href'] }
      #gon.get_link = $amex_headlines.size

        @cites = []
        @dates = []

        gon.get_cite = $amex_cite
        master_date = Array.new
        master_source = Array.new

        x = $amex_cite.size-1
        year = "2016"

        for i in 0..x
          if $amex_cite[i].include? "2016"
            year = "2016"
           
          end 

          if $amex_cite[i].include? "2015"
            year = "2015"
            
          end
          master_date.push("#{$amex_cite[i]}" + " " + "#{year}")
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
    @amex = Amex.new
    #respond_with(@amex)
  end


  def edit
  end

  def create
    @amex = Amex.new(list_params)
    @amex.save
    redirect_to amexes_path, notice: "amex Created."
  #  respond_with(@amex)
  end

  def update
    @amex.update(list_params)
    redirect_to amexes_path, notice: "amex Created."
   # respond_with(@amex)
  end

  def destroy
    @amex.destroy
    redirect_to amexes_path, notice: "amex Created."
    #respond_with(@amex)
  end

  private

    def sort_column
      Amex.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def set_list
      @amex = Amex.find(params[:id])
    end

    def list_params
      params.require(:amex).permit(:symbol, :name, :market, :country, :ipo, :sector, :alive)
    end
end
