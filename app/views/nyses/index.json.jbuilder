json.array!(@nyses) do |nyse|
  json.extract! nyse, :id, :symbol, :name, :market, :country, :ipo, :sector, :alive, :list_type
  json.url nyse_url(nyse, format: :json)
end
