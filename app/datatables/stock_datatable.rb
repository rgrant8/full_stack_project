class StockDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(table, view, user_id)
    @table = table
    @view = view
    @user_id = user_id
    find_in_SUL
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @table.count,
      iTotalDisplayRecords: market_datas.total_entries,
      aaData: data
    }
  end

private

  def data
    market_datas.map do |market_data|
      [
        market_data.symbol,
        market_data.name,
        if @store[market_data.symbol] == true
          link_to("Saved", market_data, id: "saved")
        else
          link_to("Explore", market_data)
        end
      ]
    end
  end

  def find_in_SUL
    is_saved = StockUserList.where(["users_id = ?", @user_id])
    @store = Hash.new 
       is_saved.each do |n|
         @store[n.stock_name] = true
       end
  end

  def saved(market_data)

  end  

  def market_datas
    @market_datas ||= fetch_market_datas
  end

  def fetch_market_datas
    market_datas = @table.order("#{sort_column} #{sort_direction}")
    market_datas = market_datas.page(page).per_page(per_page)
    if params[:sSearch].present?
      market_datas = market_datas.where("symbol like :search or name like :search or sector like :search", search: "%#{params[:sSearch]}%")
    end
    market_datas
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[symbol name sector id]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end